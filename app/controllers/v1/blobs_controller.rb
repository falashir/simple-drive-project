class V1::BlobsController < ApplicationController
  def create
    begin
      blob = Blob.new(blob_params)

      storage_type = params[:storage_type].nil? ? :local : params[:storage_type]
      storage_service = Factory::StorageFactory.make_storge(storage_type.to_sym)

      blob.storage_backend = storage_service
      blob.storage_backend.data = params[:data]

      raise 'Cannot decode this data!' unless blob.is_storage_backend_valid?

      blob.store_file

      if blob.save
        render json: serialize(blob), status: status
      else
        render json: blob.errors, status: :unprocessable_entity
      end
    rescue RuntimeError => e
      data = {
        status: 400,
        error: e.message
      }

      render json: data, status: :bad_request
    end
  end
  def show
    blob = Blob.find_by blob_id: params[:id]
    unless blob.nil?
      blob.retrieve_file
      render json: serialize(blob), status: status
    else
      render json: { error: 'File not found' }, status: :not_found
    end

  end


  private
  def blob_params
    params.require(:blob).permit(:blob_id)
  end

  def serialize(blob)
    {
      id: blob.blob_id,
      image: {
        file: {
          contents: blob.storage_backend.data
        }
        },
        size: blob.size,
        created_at: blob.created_at
    }
  end
end
