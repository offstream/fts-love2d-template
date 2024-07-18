-- load our custom [love.run] callback
require("run")

---@alias GameState {}

---This function is called exactly once at the beginning of the game.
---Initialize [GameState] here
---@param arg table Command-line arguments given to the game
---@param unfilteredArg table Unfiltered command-line arguments given to the executable
---@return GameState
function love.load(arg, unfilteredArg)
  return {}
end

---Update [GameState] here. Called EVERY TICK and not every Frame.
---@param state GameState
---@param dt number FIXED Tick Rate, delta time in seconds
---@return GameState
function love.update(state, dt)
  return state
end

---Interpolate [GameState] FOR DRAWING PURPOSES ONLY. Called right before every [love.draw].
---@param prev GameState
---@param curr GameState
---@param alpha number Aka, the blending factor
---@return GameState
function love.interpolate(prev, curr, alpha)
  return prev
end

---Draw interpolated [GameState] here. Called EVERY FRAME and not every Tick.
---@param state GameState The interpolated state which might not be the actual state
function love.draw(state)
  --
end
