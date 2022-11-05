module ExceptionHandler
  def self.included(klass)
    klass.class_eval do
      rescue_from Exceptions::BaseError, with: :render_error
    end
  end

  private

  def render_error(error)
    render json: error.to_payload, status: error.code
  end
end
