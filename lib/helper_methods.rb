# frozen_string_literal: true

require 'json'
require 'thread/pool'
require_relative 'breed'

def pooling(array, threads, filepath)
  pool = Thread.pool(threads)

  array.each do |element|
    pool.process do
      Breed.new(element).sniff_n_cage(filepath)
      puts Breed.new(element).fetch_image_url
    end
  end

  pool.shutdown
end

def save_to_json(save_path, json)
  File.open(save_path, 'w') do |f|
    f.write(JSON.pretty_generate(json))
  end
end

def files_updated_at(folder)
  json_path = "#{folder}updated_at.json"
  files_json = { files: [] }
  files = Dir.entries(folder).keep_if { |x| x =~ /.csv$.*?/ }

  files.each do |file|
    files_json[:files] << { file: file,
                            updated_at: File.ctime("#{folder}#{file}") }
  end

  save_to_json(json_path, files_json)
end

def prepare_output_folder(path)
  Dir.mkdir(path) unless Dir.exist?(path)
end
