module BlobFormatValidation
  def validate_name_presence
    errors.add(:data, "zzzzzzzzzzzzzzzzzz") if data =~ /^(?:[a-zA-Z0-9+\/]{4})*(?:|(?:[a-zA-Z0-9+\/]{3}=)|(?:[a-zA-Z0-9+\/]{2}==)|(?:[a-zA-Z0-9+\/]{1}===))$/
  end
end
