class Blob < ApplicationRecord
  validates :blob_id, presence: true, uniqueness: { case_sensitive: false }

  has_one :storage_backend

  def store_file(blob_id)
    self.storage_backend.store_file(self.storage_backend.data, blob_id)
  end

  def retrieve_file(blob_id)
    self.storage_backend.retrieve_file(blob_id)
  end
end
