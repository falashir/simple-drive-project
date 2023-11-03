require 'base64'

module Reusable
  module DatabaseStoring
    class << self

      def create_file(blob)
        Reusable::LocalBlob.create_file(blob)
        Reusable::LocalBlob.delete_file(blob)
      end

      def fetch_file(blob)
        blob.storage_backend.data
      end
    end
  end
end
