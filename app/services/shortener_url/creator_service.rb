class ShortenerUrl::CreatorService < ApplicationService
  include UrlHelper

  attr_accessor :orginal_url, :expired_at

  # @param  orginal_url: string
  # @param  expired_at: integer epoch time in seconds
  def initialize(original_url:, expired_at: nil)
    @original_url = original_url.to_s
    @expired_at = expired_at
  end

  def call
    # Validate url format
    raise InvalidUrlFormatError unless valid_url?(@original_url)
    # Validate expired_at if exists
    raise InvalidExpiredAtSettingError if invalid_expired_at?(@expired_at)

    begin
      # Random a new short url id
      new_base58_id, new_bigint_id = KeyGeneratorService.call
      @expired_at = Time.at(@expired_at) if @expired_at
      # Import shorten url and orginal url to database
      Url.create(
        id: new_bigint_id,
        short_url: new_base58_id,
        original_url: @original_url,
        expired_at: @expired_at
      )
    rescue ActiveRecord::RecordNotUnique
      retry
    end
  end
end
