class LocalStorage < StorageBackend

  def store_file(file)
    puts "Local storage -> #{file}"
  end
end
