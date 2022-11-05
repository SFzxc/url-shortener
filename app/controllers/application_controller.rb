class ApplicationController < ActionController::API
  include ExceptionHandler

  def data_serializer(data, serializer)
    serializable_resource = ActiveModelSerializers::SerializableResource
    serializable_resource.new(data, each_serializer: serializer).serializable_hash
  end

  def render_json(data, serializer, status = 200)
    payload = data_serializer(data, serializer)
    render json: { data: payload }, status: status
  end
end
