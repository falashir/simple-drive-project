require 'base64'

module Reusable

  DIR = Rails.root.join("file_storage", "local_storage")

  module LocalBlob
    class << self

      def create_file(blob)
        blob_id = blob.blob_id
        encoded_file = blob.storage_backend.data

        FileUtils.mkdir_p(Reusable::DIR) unless File.directory?(Reusable::DIR)

        encoded_blob = encoded_file&.include?(",") ? encoded_file.split(",")[1] : encoded_file
        new_file = File.new("#{Reusable::DIR}/#{blob_id}.png", 'wb')

        file = Base64.decode64(encoded_blob)
        new_file.write(file)

        blob.size = new_file.size
      end

      def fetch_file(blob)
        decoded = File.read("#{Reusable::DIR}/#{blob.blob_id}.png", mode: 'rb')
        encoded_data = Base64.strict_encode64(decoded)

        encoded_data
      end

      def delete_file(blob)
        File.delete("#{Reusable::DIR}/#{blob.blob_id}.png")
      end
    end
  end
end
