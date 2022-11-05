class ShortenerUrl::ExpiredUrlCleanerService < ApplicationService
  def call
    expired_urls = Url.where('expired_at IS NOT NULL and expired_at <= ?', Time.current)
    expired_urls_count = expired_urls.size
    expired_urls.delete_all
    expired_urls_count
  end
end
