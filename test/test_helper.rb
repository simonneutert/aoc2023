# frozen_string_literal: true

require 'bundler/setup'

require 'test/unit'
require 'pry'

%w[lib].each do |dir|
  Dir.glob("#{dir}/**/*.rb").each { |file| require_relative "../#{file}" }
end
