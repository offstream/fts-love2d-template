-- ticks per second
TICK_RATE = 1 / 100
-- threshold number of frames until tick frame/s must be skipped (no "spiral of death")
MAX_FRAME_SKIP = 25

function love.run()
  local curr_state
  if love.load then
    curr_state = love.load(love.arg.parseGameArguments(arg), arg)
  end

  -- We don't want the first frame's dt to include time taken by love.load.
  if love.timer then
    love.timer.step()
  end

  -- We keep track of the accumulated time using lag
  local lag = 0.0
  local prev_state = curr_state

  -- Main loop time.
  return function()
    -- Process events.
    if love.event then
      love.event.pump()
      for name, a, b, c, d, e, f in love.event.poll() do
        if name == "quit" then
          if not love.quit or not love.quit() then
            return a or 0
          end
        end
        love.handlers[name](a, b, c, d, e, f)
      end
    end

    -- Cap number of ticks that can be processed so lag doesn't accumulate
    if love.timer then
      lag = math.min(lag + love.timer.step(), TICK_RATE * MAX_FRAME_SKIP)
    end

    -- [love.update] will not be called if [love.timer] is disabled
    while lag >= TICK_RATE do
      if love.update then
        prev_state = curr_state
        curr_state = love.update(curr_state, TICK_RATE)
      end
      lag = lag - TICK_RATE
    end

    local draw_state = curr_state
    if love.interpolate then
      local alpha = lag / TICK_RATE
      draw_state = love.interpolate(prev_state, curr_state, alpha)
    end

    if love.graphics and love.graphics.isActive() then
      love.graphics.origin()
      love.graphics.clear(love.graphics.getBackgroundColor())

      if love.draw then
        love.draw(draw_state)
      end

      love.graphics.present()
    end

    -- Even though we are limitting the tick rate, we might want to cap framerate at 1000 fps as
    -- mentioned in https://love2d.org/forums/viewtopic.php?f=4&t=76998&p=198629&hilit=love.timer.sleep#p160881
    if love.timer then
      love.timer.sleep(0.001)
    end
  end
end
