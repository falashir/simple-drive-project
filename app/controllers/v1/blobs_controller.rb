class V1::BlobsController < ApplicationController
  def create
    @blob = Blob.new(blob_params)
    # @storage_service = Factory::StorageFactory.make_storge(type)
    # StorageBackend.new
    # x = @storage_service.set_storage_factory(:s3)


    puts @blob.inspect

    # render json: data, status: status
  end


  private
    def blob_params
      params.require(:blob).permit(:blob_id, :data)
    end

end
