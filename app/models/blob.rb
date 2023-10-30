class Blob < ApplicationRecord
  validates :blob_id, presence: true, uniqueness: { case_sensitive: false }
  validates :data, presence: true,
    format: { multiline: true, with: /^(?:[a-zA-Z0-9+\/]{4})*(?:|(?:[a-zA-Z0-9+\/]{3}=)|(?:[a-zA-Z0-9+\/]{2}==)|(?:[a-zA-Z0-9+\/]{1}===))$/,
              message: "Cannot decode this data!" }

  has_one :storage_backend

end
