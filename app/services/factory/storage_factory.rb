module Factory
  class StorageFactory

  STORAGE_TYPES = {
                    local: :local_storage,
                    s3: :s3_storage,
                    datbase: :database_storage
                  }

    class << self
      def make_storge(storage_type)
        send STORAGE_TYPES[storage_type]
      end

      private

      def local_storage
        LocalStorage.new
      end

      def s3_storage
        S3Storage.new
      end

      def database_storage
        LocalStorage.new
      end
    end
  end
end
