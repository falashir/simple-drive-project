class CreateBlobs < ActiveRecord::Migration[6.1]
  def change
    create_table :blobs do |t|
      t.text :data
      t.integer :size

      t.timestamps
    end
  end
end
