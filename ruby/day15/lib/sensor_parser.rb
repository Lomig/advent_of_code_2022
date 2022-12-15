# frozen_string_literal: true

require_relative "sensor"

class SensorParser
  def parse(input)
    input.map do |line|
      line.scan(/-?\d+/).map(&:to_i)
          .then { |(xs, ys, xb, yb)| Sensor.new(sensor_x: xs, sensor_y: ys, beacon_x: xb, beacon_y: yb) }
    end
  end
end
