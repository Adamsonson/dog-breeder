# frozen_string_literal: true

require 'json'
require 'net/http'

# API handler
class ApiClient
  def fetch_random_image(attribute)
    url = "https://dog.ceo/api/breed/#{attribute}/images/random"
    fetch_api_message(url)
  end

  def fetch_all_images(attribute)
    url = "https://dog.ceo/api/breed/#{attribute}/images"
    fetch_api_message(url)
  end

  def fetch_api_message(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)

    JSON.parse(response)['message']
  end
end
