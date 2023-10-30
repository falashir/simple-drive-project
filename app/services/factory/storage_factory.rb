module Factory
  class StorageFactory

  STORAGE_TYPES = {
                    local: :local_storage,
                    s3: :s3_storage,
                    database: :database_storage
                  }

    class << self
      def make_storge(storage_type)
        raise "Not supported storage" if STORAGE_TYPES[storage_type].nil?
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
        DatabaseStorage.new
      end
    end
  end
end
