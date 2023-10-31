require "base64"

require 'aws-sigv4'
require 'net/http'

module Reusable
  module S3Connection
    class << self

      # These credintials sould be encrypted
      Access_key = "AKIAXHR6Z6CGMFQTQTFW"
      Secret_key = "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"
      Region = "eu-central-1"
      S3_bucket = "moyasar-project"

      def send_to_s3(blob)
        decoded_data = Base64.decode64(blob.storage_backend.data)
        set_blob_size(blob, decoded_data)

        s3_object_key = "#{blob.blob_id}.png"
        endpoint = "https://#{S3_bucket}.s3.amazonaws.com/#{s3_object_key}"

        uri = URI.parse(endpoint)
        request = Net::HTTP::Put.new(uri.request_uri)
        request.body = decoded_data

        # Sign the request with AWS SigV4
        signer = Aws::Sigv4::Signer.new(
          service: 's3',
          region: Region,
          access_key_id: Access_key,
          secret_access_key: Secret_key
        )
        signed_request = signer.sign_request(
          http_method: 'PUT',
          url: endpoint,
          body: decoded_data
        )

        request.initialize_http_header(signed_request.headers)

        # Create an HTTP connection
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        # Send the HTTP request
        response = http.request(request)

        raise "Error: #{response.code} - #{response.message}" unless response.code.to_i == 200
      end

      def retrieve_from_s3(blob)
        s3_object_key = "#{blob.blob_id}.png"
        endpoint = "https://#{S3_bucket}.s3.amazonaws.com/#{s3_object_key}"

        uri = URI.parse(endpoint)
        request = Net::HTTP::Get.new(uri.request_uri)

        signer = Aws::Sigv4::Signer.new(
          service: 's3',
          region: Region,
          access_key_id: Access_key,
          secret_access_key: Secret_key
        )
        signed_request = signer.sign_request(
          http_method: 'GET',
          url: endpoint
        )
        request.initialize_http_header(signed_request.headers)

        # Create an HTTP connection
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        # Send the HTTP request
        response = http.request(request)

        if response.code.to_i == 200
          Base64.encode64(response.body)
        else
          raise "Error: #{response.code} - #{response.message}"
        end
      end

      private
      def set_blob_size(blob, decoded_data)
        dir = File.dirname("file_storage/local_storage/tmp")
        new_file = File.new("#{dir}/#{blob.blob_id}.png", 'wb')
        new_file.write(decoded_data)
        blob.size = new_file.size
        File.delete("#{dir}/#{blob.blob_id}.png")
      end
    end
  end
end
