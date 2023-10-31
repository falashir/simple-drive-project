class V1::BlobsController < ApplicationController
  before_action :is_valid_token, except: :user_token

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
    begin
      blob = Blob.find_by blob_id: params[:id]
      unless blob.nil?
        blob.retrieve_file
        render json: serialize(blob), status: status
      else
        render json: { error: "File not found" }, status: :not_found
      end
    rescue => e
      render json: { error: e.message }, status: :bad_request
    end


  end

  def user_token
    begin
      password = params[:password] unless params[:password].nil?
      raise "Wrong passord!" if password != "password"

      payload = { data: password }
      token = JWT.encode payload, nil, 'none'

      data = {
        auth_token: token
      }

      render json: data, status: status
    rescue => e
      render json: { data: e.message }, status: :unauthorized
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

  def is_valid_token
    begin
      if request.headers.key?('Authorization')
        token = request.headers[:Authorization].split(" ")[1]
        decoded_token = JWT.decode token, nil, false
        data = decoded_token.reduce Hash.new, :merge
        passowd = data["data"].to_s

        puts passowd == "password"

        raise "Unauthorized" unless passowd == "password"
      else
        raise "Unauthorized"
      end
    rescue => e
      render json: { data: e.message, auth: "Unauthorized" } , status: :unauthorized
    end
  end

end
