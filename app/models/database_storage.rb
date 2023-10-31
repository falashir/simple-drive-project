class DatabaseStorage < StorageBackend
  validates :data, presence: true,
    format: { multiline: true, with: /^(?:[a-zA-Z0-9+\/]{4})*(?:|(?:[a-zA-Z0-9+\/]{3}=)|(?:[a-zA-Z0-9+\/]{2}==)|(?:[a-zA-Z0-9+\/]{1}===))$/,
              message: "Cannot decode this data!" }

  def store_file(blob)
    puts "database storage -> #{blob}"
  end
end
