# frozen_string_literal: true

require 'bundler/setup'
require 'pry'
require 'test/unit'

Dir.glob('lib/**/*.rb').each do |file|
  puts "requiring file: #{file}"
  require_relative file
end

system('rake test')
