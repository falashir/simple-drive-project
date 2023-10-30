class AddBlobIdToStorageBackend < ActiveRecord::Migration[6.1]
  def change
    add_column :storage_backends, :blob_id, :string
  end
end
