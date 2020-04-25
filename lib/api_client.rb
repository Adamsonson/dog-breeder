# frozen_string_literal: true

require 'json'

# Communicates to API
class ApiClient
  def fetch_random_image(attribute)
    url = "https://dog.ceo/api/breed/#{attribute}/images/random"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    return 'not found' if JSON.parse(response)['status'] != 'success'

    JSON.parse(response)['message']
  end
end
