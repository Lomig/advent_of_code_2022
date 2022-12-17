# frozen_string_literal: true

class Chamber
  SPAWN_MARGIN_ABOVE_SKYLINE = 3

  private attr_reader :spawner, :state_manager, :occupied
  private attr_accessor :current_piece, :piece_count, :piece_index

  def initialize(spawner:, state_manager:)
    @spawner = spawner
    @spawner.chamber = self

    @state_manager = state_manager

    @occupied = Hash.new(Hash.new(false))
    @piece_count = 0

    spawn!
  end

  def tick!(gust_of_wind, wind_index: nil , max_piece_count: nil)
    if piece_index && wind_index
      cycle_status = state_manager.add_or_find_state(wind_index:, piece_index:, skyline:, piece_count:, height:)

      return cycle_status if cycle_status[0] == :exists
    end

    self.piece_index = nil

    tick(gust_of_wind, max_piece_count:)
  end

  def occupied?(point)
    occupied[point.y][point.x] || point.x < 0 || point.x >= 7 || point.y < 0
  end

  def lock(points)
    points.each { |point| occupied[point.y] = occupied[point.y].merge({point.x => true }) }

    self.piece_count += 1
    self.current_piece = nil
  end

  private

  def tick(gust_of_wind, max_piece_count:)      
    current_piece.send(gust_of_wind)
    current_piece.down!

    spawn! unless current_piece

    return [:completed, height] if max_piece_count == piece_count

    [:ticking]
  end

  def spawn!
    self.current_piece, self.piece_index =
      spawner.next_with_index(spawn_row: height + SPAWN_MARGIN_ABOVE_SKYLINE)
  end

  def height
    row_index = occupied.keys
    return 0 if row_index.empty?

    row_index.max + 1
  end

  def skyline
    7.times.with_object(Array.new(7, 0)) do |x, skyline|
      height.downto(0) do |y|
        break skyline[x] = y if occupied[y][x]
      end
    end => skyline

    skyline.map { |x| x - skyline.min }
  end
end
