# frozen_string_literal: true

module Clockable

  def on_tick(cycle)
    return if idle?
  end

  def idle? = @is_idle

  private

  def halt!
    @is_idle = true
  end
end
