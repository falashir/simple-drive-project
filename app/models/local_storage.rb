require 'fileutils'

class LocalStorage < StorageBackend

  def store_file(blob)
    Reusable::LocalBlob.create_file(blob)
  end

  def retrieve_file
    self.data = Reusable::LocalBlob.fetch_file(self.blob)
  end
end
