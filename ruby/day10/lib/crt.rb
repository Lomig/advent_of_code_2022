# frozen_string_literal: true

require_relative "clockable"

class CRT
  include Clockable

  WIDTH = 40
  HEIGHT = 6

  private attr_reader :cpu, :screen
  private attr_accessor :sprite_position

  def initialize(cpu:)
    @cpu = cpu
    @screen = []
    @sprite_position = 1
    @is_idle = false
  end

  def display
    puts

    screen.each_slice(WIDTH) do |line|
      print " " * 19
      puts line.join
    end

    nil
  end

  def on_tick(cycle)
    super

    draw_next_pixel(cycle - 1)
    self.sprite_position = cpu.x
  end

  private

  def draw_next_pixel(pixel_index)
    return halt! if pixel_index == WIDTH * HEIGHT

    screen << pixel(pixel_index)
  end

  def pixel(pixel_index)
    (sprite_position - 1 .. sprite_position + 1).include?(pixel_index % WIDTH) ? "█" : " "
  end
end
