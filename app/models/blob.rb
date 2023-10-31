class Blob < ApplicationRecord
  has_one :storage_backend

  validates :blob_id, presence: true, uniqueness: { case_sensitive: false }

  def store_file()
    self.storage_backend.store_file(self)
  end

  def retrieve_file
    self.storage_backend.retrieve_file
  end

  def is_storage_backend_valid?
    self.storage_backend.valid?
  end
end
