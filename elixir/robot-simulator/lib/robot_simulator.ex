defmodule RobotSimulator do
  @directions [:north, :east, :south, :west]

  defguard both_numbers?(n, m) when is_number(n) and is_number(m)

  # defguard valid_direction?(direction) when direction in Map.keys(@directions)

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create() do
    {:north, {0, 0}}
  end

  def create(direction, _position) when direction not in @directions do
    {:error, "invalid direction"}
  end

  def create(_direction, {pos1, pos2}) when not both_numbers?(pos1, pos2) do
    {:error, "invalid position"}
  end

  def create(direction, {_pos1, _pos2} = position) do
    {direction, position}
  end

  def create(_direction, _position) do
    {:error, "invalid position"}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t() | list()) :: any
  def simulate(robot, instructions) when is_binary(instructions) do
    simulate(robot, String.split(instructions, "", trim: true))
  end

  def simulate(robot, []) do
    robot
  end

  def simulate({dir, pos}, [inst | rest]) do
    cond do
      inst in ~w(L R) ->
        simulate({turn(dir, inst), pos}, rest)

      inst == "A" ->
        simulate({dir, advance(dir, pos)}, rest)

      true ->
        {:error, "invalid instruction"}
    end
  end

  @spec turn(atom, String.t()) :: atom
  def turn(direction, instruction) do
    cond do
      instruction == "L" ->
        nextl(@directions, direction)

      instruction == "R" ->
        nextr(@directions, direction)
    end
  end

  @spec nextr(list(), atom) :: atom
  def nextr([head | tail], dir) when head != dir do
    nextr(tail ++ [head], dir)
  end

  def nextr([_first, next | _rest], _dir) do
    next
  end

  @spec nextl(list(), atom) :: atom
  def nextl([_first, next | _rest] = list, dir) when next != dir do
    {last, rest} = List.pop_at(list, length(list) - 1)
    nextl([last] ++ rest, dir)
  end

  def nextl([first, _next | _rest], _dir) do
    first
  end

  @spec advance(:east | :north | :south | :west, {number(), number()}) :: {number(), number()}
  def advance(dir, {x, y}) do
    case dir do
      :north ->
        {x, y + 1}

      :east ->
        {x + 1, y}

      :south ->
        {x, y - 1}

      :west ->
        {x - 1, y}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction({direction, _position}) do
    direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position({_direction, position}) do
    position
  end
end
