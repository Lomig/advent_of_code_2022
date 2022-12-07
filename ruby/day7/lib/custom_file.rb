# frozen_string_literal: true

class CustomFile
  attr_reader :name, :size

  def initialize(file_name:, size:)
    @name = file_name
    @size = size
  end
end
