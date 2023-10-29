class CreateBlobs < ActiveRecord::Migration[6.1]
  def change
    create_table :blobs do |t|
      t.string :id
      t.text :data
      t.integer :size
      t.datetime :created_at

      t.timestamps
    end
  end
end
