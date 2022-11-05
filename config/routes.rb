Rails.application.routes.draw do
  namespace :v1 do
    post '/shorten/encode', to: 'url_shortener#create'
    get  '/shorten/decode/:id', to: 'url_shortener#show'
  end
end
