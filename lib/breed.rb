# frozen_string_literal: true

require_relative 'api_client'
require_relative 'csv_worker'

# Searches breed image and saves it to
# separate CVS file within timestamp folder
class Breed
  def initialize(name)
    @name = name
    @client = ApiClient.new
    @csv = CsvWorker.new(@name)
  end

  def save_to_csv(filepath)
    @csv.save_to(filepath, fetch_images)
  end

  def fetch_image_url
    @client.fetch_random_image(@name)
  end

  def fetch_images
    @client.fetch_all_images(@name)
  end
end
