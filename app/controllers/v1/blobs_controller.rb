class V1::BlobsController < ApplicationController
  def create
    begin
      @blob = Blob.new(blob_params)

      storage_type = params[:storage_type].nil? ? :local : params[:storage_type]
      storage_service = Factory::StorageFactory.make_storge(storage_type.to_sym)
      @blob.storage_backend = storage_service

      if @blob.save
        render json: @blob, status: status
      else
        render json: @blob.errors, status: :unprocessable_entity
      end
    rescue RuntimeError => e
      data = {
        status: 400,
        error: e.message
      }

      render json: data, status: :bad_request
    end
  end


  private
    def blob_params
      params.require(:blob).permit(:blob_id, :data)
    end
end
