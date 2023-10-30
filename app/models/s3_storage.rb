class S3Storage < StorageBackend

  def store_file(file)
    puts "S3 storage -> #{file}"
  end
end
