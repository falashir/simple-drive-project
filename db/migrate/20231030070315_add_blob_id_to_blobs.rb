class AddBlobIdToBlobs < ActiveRecord::Migration[6.1]
  def change
    add_column :blobs, :blob_id, :string
  end
end
