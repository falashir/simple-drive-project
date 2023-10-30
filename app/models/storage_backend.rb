class StorageBackend < ApplicationRecord

  def store_file(file)
    raise "No implemented error"
  end

  def set_storage_factory(type)
    Factory::StorageFactory.make_storge(type)
  end
end
