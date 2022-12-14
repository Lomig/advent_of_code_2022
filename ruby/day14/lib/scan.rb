# frozen_string_literal: true

require_relative "tile"

class Scan
  SAND_ENTRY  = Tile(500, 0)

  private attr_reader :scan
  private attr_accessor :bedrock_level

  def initialize(rock_paths:)
    @scan = {}
    @bedrock_level = 0

    rock_paths.each(&draw_paths!)
  end

  def avalanche!(mode: nil)
    result = drop_sand!(mode:) until result == :completed
    self
  end

  def sand_capacity = scan.values.count(&:sand?)

  private

  def drop_sand!(current_position: SAND_ENTRY, mode:)
    new_position = next_sand_position(current_position:)

    return :completed if new_position == SAND_ENTRY
    return add_tile(current_position) if new_position == current_position
    return :completed if mode == :bottomless_pit && below_bedrock?(new_position)

    drop_sand!(current_position: new_position, mode:)
  end

  def next_sand_position(current_position:)
    x, y = current_position.x, current_position.y

    return current_position if y == bedrock_level + 1
    return Tile(x, y + 1) unless scan[[x, y + 1]]
    return Tile(x - 1, y + 1) unless scan[[x - 1, y + 1]]
    return Tile(x + 1, y + 1) unless scan[[x + 1, y + 1]]

    return current_position
  end

  def below_bedrock?(position) = position.y >= bedrock_level

  def draw_paths! = ->(rock_paths) { rock_paths.each(&draw_path) }

  def draw_path = lambda do |rock_path|
    startx, endx = rock_path.map(&:first).sort
    starty, endy = rock_path.map(&:last).sort
    
    startx.upto(endx) do |x|
      starty.upto(endy) { |y| add_tile(Tile(x, y, type: :rock)) }
    end
  end

  def add_tile(tile)
    scan[[tile.x, tile.y]] ||= tile

    self.bedrock_level = tile.y if tile.y > bedrock_level && tile.type == :rock
  end
end
