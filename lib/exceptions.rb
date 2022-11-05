module Exceptions
  class BaseError < StandardError
    attr_reader :message, :type, :code

    def initialize(message: nil, code: 422)
      @type = self.class.name.demodulize.underscore
      @message = message || @type.humanize
      @code ||= code
      super()
    end

    def to_payload
      {
        error: {
          message: @message,
          type: @type,
          code: @code
        }
      }
    end
  end

  class NotFoundIdError < BaseError; end
  class InvalidShortenUrlError < BaseError; end
  class InvalidUrlFormatError < BaseError; end
  class NotFoundShortenUrlError < BaseError; end
  class InvalidExpiredAtSettingError < BaseError; end
end
