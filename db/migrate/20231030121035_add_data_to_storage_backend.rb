class AddDataToStorageBackend < ActiveRecord::Migration[6.1]
  def change
    add_column :storage_backends, :data, :text
    remove_column :blobs, :data
  end
end
