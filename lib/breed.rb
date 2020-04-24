# frozen_string_literal: true

require 'csv'
require 'net/http'

# Searches breed image and saves it to
# separate CVS file within timestamp folder
class Breed
  def initialize(name)
    @name = name
  end

  def sniff_n_cage(filepath)
    cage_to_csv(@name, filepath)
  end

  private

  def cage_to_csv(breed, filepath)
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    csv_filepath = "#{filepath}#{breed}.csv"

    CSV.open(csv_filepath, 'wb', csv_options) do |csv|
      csv << %w[breed_name link_to_image]
      csv << [breed, fetch_image_url(breed)]
    end
  end

  def fetch_image_url(breed)
    url = "https://dog.ceo/api/breed/#{breed}/images/random"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    return 'not found' if JSON.parse(response)['status'] != 'success'

    JSON.parse(response)['message']
  end
end
