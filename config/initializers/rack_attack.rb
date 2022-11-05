# Max 20 requests each 5 seconds per ip
Rack::Attack.throttle("requests by ip", limit: 20, period: 5.seconds) do |request|
  request.ip
end
