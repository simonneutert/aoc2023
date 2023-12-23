# frozen_string_literal: true

class RiddleNext
  def initialize(filename)
    @filename = filename
    read_file
  end

  private

  def read_file
    @input = File.read(File.path(__dir__) + @filename).split("\n")
  end
end
