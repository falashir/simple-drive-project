class S3Storage < StorageBackend

  def store_file(blob)
    Reusable::S3Connection.send_to_s3(blob)
  end

  def retrieve_file
    data = Reusable::S3Connection.retrieve_from_s3(blob)
  end
end
