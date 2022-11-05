class ShortenerUrl::FinderService < ApplicationService
  def initialize(short_id)
    @short_id = short_id.to_s
  end

  def call
    url_id = Base58.decode(@short_id)
    cache_key = ['Url', url_id]
    url = Rails.cache.read(cache_key)
    return url if url

    url = Url.find_by(id: url_id)
    raise NotFoundShortenUrlError.new(code: 404) unless url

    Rails.cache.write(cache_key, url, expires_in: 12.hours)

    url
  rescue ArgumentError # Catch Base58.decode error
    raise InvalidShortenUrlError
  end
end
