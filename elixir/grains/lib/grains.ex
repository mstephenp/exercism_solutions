defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(any) :: {:error, String.t()} | {:ok, integer}
  def square(number) when number <= 0 do
    {:error, "The requested square must be between 1 and 64 (inclusive)"}
  end

  def square(number) when number > 64 do
    {:error, "The requested square must be between 1 and 64 (inclusive)"}
  end

  def square(number) do
    {:ok, trunc(:math.pow(2, number - 1))}
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, any}
  def total() do
    {:ok, Enum.reduce(1..64, 0, &(&2 + elem(square(&1), 1)))}
  end
end
