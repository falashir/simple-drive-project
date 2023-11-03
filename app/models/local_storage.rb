class LocalStorage < StorageBackend
  include ActiveModel::Validations

  validates :data,
            presence: true,
            format:
            { multiline: true,
              with: /^(?:[a-zA-Z0-9+\/]{4})*(?:|(?:[a-zA-Z0-9+\/]{3}=)|(?:[a-zA-Z0-9+\/]{2}==)|(?:[a-zA-Z0-9+\/]{1}===))$/,
              message: "Cannot decode this data!" }


  def store_file(blob)
    Reusable::LocalBlob.create_file(blob)
  end

  def retrieve_file
    data = Reusable::LocalBlob.fetch_file(blob)
  end
end
