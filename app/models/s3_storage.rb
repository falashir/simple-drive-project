class S3Storage < StorageBackend

  def store_file(encoded_file, blob_id)
    puts "S3 storage -> #{encoded_file}"
  end
end
