# == Schema Information
#
# Table name: urls
#
#  id           :bigint           not null, primary key
#  expired_at   :datetime
#  original_url :string           not null
#  short_url    :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_urls_on_expired_at  (expired_at)
#  index_urls_on_short_url   (short_url) UNIQUE
#
class UrlSerializer < ActiveModel::Serializer
  attributes :short_url,
             :original_url

  # @override
  def short_url
    BASE_HOST + object.short_url
  end
end
