require 'rails_helper'

RSpec.describe 'V1::UrlShorteners', type: :request do
  application_json

  before(:each) do
    @valid_payload = { original_url: 'https://app.codesubmit.io/c/namiai/46757c8b-8532-460f-8120' }
    @invalid_payload = { original_url: 'https://app' }
    @invalid_payload2 = @valid_payload.merge({ expired_at:  10.minutes.ago.to_i })
  end

  describe 'POST /v1/shorten/encode' do
    describe 'create a shorten url with valid original url' do
      it 'should returns 201' do
        post '/v1/shorten/encode', params: @valid_payload.to_json, headers: headers

        expect(response).to have_http_status(:created)
        data = JSON.parse(response.body)['data']

        expect(data['original_url']).to eq(@valid_payload[:original_url])
        expect(Url.count).to eq(1)
      end
    end
    describe 'create a shorten url with invalid original url' do
      it 'should raise error' do
        post '/v1/shorten/encode', params: @invalid_payload.to_json, headers: headers

        body = JSON.parse(response.body)

        expect(body['error']['code']).to eq(422)
        expect(body['error']['type']).to eq('invalid_url_format_error')
      end
    end
    describe 'create a shorten url with valid original url but invalid expired_at' do
      it 'should raise error' do
        post '/v1/shorten/encode', params: @invalid_payload2.to_json, headers: headers

        body = JSON.parse(response.body)

        expect(body['error']['code']).to eq(422)
        expect(body['error']['type']).to eq('invalid_expired_at_setting_error')
      end
    end
  end

  describe 'GET /v1/shorten/decode/:id' do
    describe 'decode a existing shorten url' do
      it 'should returns 200' do
        url = ShortenerUrl::CreatorService.call(original_url: @valid_payload[:original_url])
        get "/v1/shorten/decode/#{url.short_url}", headers: headers

        expect(response.status).to eq(200)
        data = JSON.parse(response.body)['data']
        expect(data['original_url']).to eq(url.original_url)
      end
    end
    describe 'decode a non existing shorten url' do
      it 'should raise error' do
        get '/v1/shorten/decode/gUvRUBS', headers: headers
        body = JSON.parse(response.body)
        expect(body['error']['code']).to eq(404)
        expect(body['error']['type']).to eq('not_found_shorten_url_error')
      end
    end

    describe 'decode an invalid shorten url format' do
      it 'should raise error' do
        get '/v1/shorten/decode/@!UvRUBS', headers: headers
        body = JSON.parse(response.body)
        expect(body['error']['code']).to eq(422)
        expect(body['error']['type']).to eq('invalid_shorten_url_error')
      end
    end
  end
end
