require 'net/http'
require 'dotenv/load'
require 'json'

class DistanceService
  API_KEY = ENV['DISTANCE_API_KEY']

  def self.get_distance(from, to)
    base_url = 'https://api.distancematrix.ai/maps/api/distancematrix/json'
    params = {
      origins: from,
      destinations: to,
      key: API_KEY
    }

    uri = URI(base_url)
    uri.query = URI.encode_www_form(params)

    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    if data['status'] == 'OK'
      element = data['rows'][0]['elements'][0]
      if element['status'] == 'OK'
        distance_meters = element['distance']['value']
        (distance_meters / 1000.0).round(1) # км
      else
        raise "Ошибка в расчёте расстояния: #{element['status']}"
      end
    else
      raise "Ошибка в API: #{data['status']}"
    end
  rescue => e
    puts "Ошибка получения расстояния: #{e.message}"
    0
  end
end