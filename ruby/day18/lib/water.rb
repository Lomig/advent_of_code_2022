# frozen_string_literal: true

require_relative "cube"

class Water
  MARGIN_TO_ENSURE_WATER_AROUND_DROPLETS = 20

  attr_reader :droplet_surfaces

  private attr_reader :field, :size
  private attr_writer :droplet_surfaces

  def initialize(size:, droplets:)
    @size = size + MARGIN_TO_ENSURE_WATER_AROUND_DROPLETS
    @field = Array.new(@size) { Array.new(@size) { Array.new(@size) } }
    @droplet_surfaces = 0

    droplets.each { |droplet| @field[droplet.x][droplet.y][droplet.z] = droplet }
  end

  def flood!
    queue = [Cube.new(0, 0, 0, type: :unknown)]

    queue = flood_next_zone(queue) until queue.empty?

    self
  end

  private

  def flood_next_zone(queue)
    current_zone = queue.shift

    x = current_zone.x
    y = current_zone.y
    z = current_zone.z

    return queue if [x, y, z].min < -MARGIN_TO_ENSURE_WATER_AROUND_DROPLETS
    return queue if [x, y, z].max >= size
    return queue if steam?(current_zone)

    if droplet?(current_zone)
      self.droplet_surfaces += 1
      return queue
    end

    field[x][y][z] = current_zone.as_steam

    queue << current_zone.left
    queue << current_zone.right
    queue << current_zone.top
    queue << current_zone.bottom
    queue << current_zone.front
    queue << current_zone.back
  end

  def droplet?(zone)
    field[zone.x][zone.y][zone.z]&.type == :droplet
  end

  def steam?(zone)
    field[zone.x][zone.y][zone.z]&.type == :steam
  end
end
