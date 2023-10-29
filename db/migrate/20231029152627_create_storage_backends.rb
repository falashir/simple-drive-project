class CreateStorageBackends < ActiveRecord::Migration[6.1]
  def change
    create_table :storage_backends do |t|
      t.string :name
      t.string :type
      t.text :config

      t.timestamps
    end
  end
end
