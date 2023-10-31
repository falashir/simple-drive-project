require 'base64'

module Reusable
  module DatabaseStoring
    class << self

      DIR = File.dirname("file_storage/local_storage/tmp")

      def create_file(blob)
        blob_id = blob.blob_id
        encoded_file = blob.storage_backend.data

        FileUtils.mkdir_p(DIR) unless File.directory?(DIR)

        encoded_blob = encoded_file&.include?(",") ? encoded_file.split(",")[1] : encoded_file
        new_file = File.new("#{DIR}/#{blob_id}.png", 'wb')

        file = Base64.decode64(encoded_blob)
        new_file.write(file)

        blob.size = new_file.size

        File.delete("#{DIR}/#{blob.blob_id}.png")
      end

      def fetch_file(blob)
        blob.storage_backend.data
      end
    end
  end
end
