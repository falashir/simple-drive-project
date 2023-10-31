class StorageBackend < ApplicationRecord

  validates :data,
            presence: true,
            format:
            { multiline: true,
              with: /^(?:[a-zA-Z0-9+\/]{4})*(?:|(?:[a-zA-Z0-9+\/]{3}=)|(?:[a-zA-Z0-9+\/]{2}==)|(?:[a-zA-Z0-9+\/]{1}===))$/,
              message: "Cannot decode this data!" }

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
