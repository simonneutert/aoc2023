# frozen_string_literal: true

class Riddle12
  def initialize(filename)
    @filename = filename
    read_file
  end

  private

  def read_file
    @input = File.read(File.path(__dir__) + @filename).split("\n")
  end
end
