# frozen_string_literal: true

class Computer
  private attr_reader :root, :total_space
  private attr_accessor :current_directory

  def initialize(instructions:, total_space:)
    @current_directory = @root = Directory.new(directory_name: "/")
    @total_space = total_space

    execute_instructions!(instructions:, executer: parse_command_line)
  end

  def sum_directory_size_at_most(amount:)
    Directory.all
             .map(&:size)
             .reject { |size| size > amount }
             .sum
  end

  def free_space(amount:)
    available_space = total_space - root.size
    space_to_free = amount - available_space

    Directory.all
             .map(&:size)
             .reject { |size| size < space_to_free }
             .min
  end

  private

  def execute_instructions!(instructions:, executer:) = instructions.each(&executer)

  def parse_command_line = lambda { |instruction|
    case instruction
    in {instruction: "ls", data:}           then execute_instructions!(instructions: data, executer: create_nodes)
    in {instruction: "cd", arguments: "/"}  then self.current_directory = root
    in {instruction: "cd", arguments: ".."} then self.current_directory = current_directory.cd_back
    in {instruction: "cd", arguments:}      then self.current_directory = current_directory.cd(arguments)
    end
  }
  
  def create_nodes = lambda { |file_data|
    case file_data.split(" ")
    in ["dir", directory_name] then current_directory.mk_dir(directory_name)
    in [size, file_name]       then current_directory.touch(file_name:, size: size.to_i)
    end
  }
end
