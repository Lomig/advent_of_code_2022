# frozen_string_literal: true

class Directory
  @@directories = []

  attr_reader :name

  private attr_reader :parent_directory, :content

  def initialize(directory_name:, parent_directory: nil)
    @name = directory_name
    @parent_directory = parent_directory || self
    @content = Hash.new(self)

    @@directories << self
  end

  def size = content.values.sum(&:size)

  def cd(directory_name) = content[directory_name]

  def cd_back = parent_directory

  def mk_dir(directory_name)
    return if content.has_key?(directory_name)

    content[directory_name] = Directory.new(directory_name:, parent_directory: self)
  end

  def touch(file_name:, size:)
    return if content.has_key?(file_name)

    content[file_name] = CustomFile.new(file_name:, size:)
  end

  class << self
    def all = @@directories
  end
end
