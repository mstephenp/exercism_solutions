defmodule RobotSimulator do
  @directions [:north, :east, :south, :west]

  defmodule Robot do
    defstruct [direction: :north, position: {0,0}]
  end

  defguard both_numbers?(pos1, pos2) when is_number(pos1) and is_number(pos2)

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  def create() do
    %Robot{}
  end

  def create(direction, _position) when direction not in @directions do
    {:error, "invalid direction"}
  end

  def create(_direction, {pos1, pos2}) when not both_numbers?(pos1, pos2) do
    {:error, "invalid position"}
  end

  def create(direction, {_pos1, _pos2} = position) do
    %Robot{direction: direction, position: position}
  end

  def create(_direction, _position) do
    {:error, "invalid position"}
  end


  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(any, binary | maybe_improper_list) :: any
  def simulate(robot, instructions) when is_binary(instructions) do
    simulate(robot, String.split(instructions, "", trim: true))
  end

  def simulate(robot, []) do
    robot
  end

  def simulate(robot, [inst | rest]) do
    cond do
      inst in ~w(L R) ->
        simulate(turn(robot, inst), rest)

      inst == "A" ->
        simulate(advance(robot), rest)

      true ->
        {:error, "invalid instruction"}
    end
  end

  @spec turn(Robot.t(), String.t()) :: Robot.t()
  def turn(robot, instruction) do
    cond do
      instruction == "L" ->
        nextl(@directions, robot)

      instruction == "R" ->
        nextr(@directions, robot)
    end
  end

  @spec nextr(list(), Robot.t()) :: Robot.t()
  def nextr([head | tail], robot) when head != robot.direction do
    nextr(tail ++ [head], robot)
  end

  def nextr([_first, next | _rest], robot) do
    %{robot | direction: next}
  end

  @spec nextl(list(), Robot.t()) :: Robot.t()
  def nextl([_first, next | _rest] = list, robot) when next != robot.direction do
    {last, rest} = List.pop_at(list, length(list) - 1)
    nextl([last] ++ rest, robot)
  end

  def nextl([first, _next | _rest], robot) do
    %{robot | direction: first}
  end

  @spec advance(Robot.t()) :: Robot.t()
  def advance(%Robot{direction: direction, position: {x, y}} = robot) do
    case direction do
      :north ->
        %{robot | position: {x, y + 1}}

      :east ->
        %{robot | position: {x + 1, y}}

      :south ->
        %{robot | position: {x, y - 1}}

      :west ->
        %{robot | position: {x - 1, y}}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: Robot) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: Robot) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
