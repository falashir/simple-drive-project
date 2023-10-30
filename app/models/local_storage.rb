require 'fileutils'

class LocalStorage < StorageBackend

  def store_file(encoded_file, blob_id)
    create_file(encoded_file, blob_id)
  end

  def retrieve_file(blob_id)
    fetch_file(blob_id)
  end

  private

  DIR = File.dirname("file_storage/local_storage/tmp")

  def create_file(encoded_file, blob_id)
    FileUtils.mkdir_p(DIR) unless File.directory?(DIR)

    blob = encoded_file&.include?(",") ? encoded_file.split(",")[1] : encoded_file
    new_file = File.new("#{DIR}/#{blob_id}.png", 'wb')

    file = Base64.decode64(blob)
    new_file.write(file)

    self.blob.size = new_file.size
  end

  def fetch_file(blob_id)
    send_file("#{DIR}/#{blob_id}.png",
      :filename => "#{blob_id}.png",
      :type => "mime/type")
  end
end
