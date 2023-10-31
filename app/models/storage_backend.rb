class StorageBackend < ApplicationRecord

  belongs_to :blob

  def store_file(blob)
    raise "No implemented error"
  end

  def retrieve_file
    raise "No implemented error"
  end

  def set_storage_factory(type)
    Factory::StorageFactory.make_storge(type)
  end
end
