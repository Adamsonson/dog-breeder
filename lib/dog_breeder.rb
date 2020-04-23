# frozen_string_literal: true

require 'csv'
require 'net/http'
require 'json'
require 'pry'

breeds = ARGV

def image_url(breed)
  url = "https://dog.ceo/api/breed/#{breed}/images/random"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  return 'not found' if JSON.parse(response)['status'] != 'success'

  JSON.parse(response)['message']
end

def csv_storing(array)
  array.each do |element|
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    filepath    = "lib/outcome/#{element}.csv"

    CSV.open(filepath, 'wb', csv_options) do |csv|
      csv << %w[breed_name link_to_image]
      csv << [element, image_url(element)]
    end
  end
end

csv_storing(breeds)
