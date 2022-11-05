class V1::UrlShortenerController < ApplicationController
  def create
    url = ShortenerUrl::CreatorService.call(create_params)
    render_json(url, UrlSerializer, 201)
  end

  def show
    url = ShortenerUrl::FinderService.call(params[:id])
    render_json(url, UrlSerializer)
  end

  def create_params
    params.permit(:original_url, :expired_at).to_h.symbolize_keys
  end
end
