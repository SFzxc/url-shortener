module UrlHelper
  extend ActiveSupport::Concern

  # SCHEMES = %w[http https]

  # def valid_url?(url)
  #   parsed = Addressable::URI.parse(url) or return false
  #   SCHEMES.include?(parsed.scheme)
  # rescue Addressable::URI::InvalidURIError
  #   false
  # end

  def valid_url?(url)
    return false if url.include?('<script')

    valid_url_regexp = %r{\A(http|https)://[a-z0-9]+([\-.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(/.*)?\z}ix
    url =~ valid_url_regexp ? true : false
  end

  def invalid_expired_at?(expired_at)
    return false unless expired_at

    Time.at(expired_at.to_i) <= Time.current
  end
end
