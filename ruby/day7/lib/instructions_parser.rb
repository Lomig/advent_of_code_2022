# frozen_string_literal: true

class InstructionsParser
  def parse(input)
    input.slice_when { |_, stop| stop.start_with?(?$) }
         .map { |line| { **seperate_instruction_from_arg(line), data: line }}
  end

  def seperate_instruction_from_arg(instruction)
    bare_instruction = instruction.shift.delete_prefix("$ ")
    {instruction: bare_instruction[..1], arguments: bare_instruction[3..]}
  end
end
