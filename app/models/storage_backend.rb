class StorageBackend < ApplicationRecord

  belongs_to :blob

  def store_file(encoded_file, blob_id)
    raise "No implemented error"
  end

  def set_storage_factory(type)
    Factory::StorageFactory.make_storge(type)
  end
end
