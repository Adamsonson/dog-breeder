# frozen_string_literal: true

require_relative 'lib/helper_methods'

INPUT = ARGV.uniq
THREAD_LIMIT = 5
OUTPUT_FILEPATH = 'saved_breeds/'

def execute
  prepare_output_folder(OUTPUT_FILEPATH)
  pooling(INPUT, THREAD_LIMIT, OUTPUT_FILEPATH)
  files_updated_at(OUTPUT_FILEPATH)
end

execute
