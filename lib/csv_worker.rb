# frozen_string_literal: true

require 'csv'

# CSV handler
class CsvWorker
  def initialize(name)
    @name = name
  end

  def save_to(path, input_data)
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    csv_filepath = "#{path}#{@name}.csv"

    CSV.open(csv_filepath, 'wb', csv_options) do |csv|
      csv << %w[breed_name link_to_image]
      handle(input_data, csv)
    end
  end

  def handle(data, csv)
    return csv << [@name, data] if data.is_a? String

    return data.each { |line| csv << [@name, line] } if data.is_a? Array

    csv << [@name, 'response data not handled']
  end
end
