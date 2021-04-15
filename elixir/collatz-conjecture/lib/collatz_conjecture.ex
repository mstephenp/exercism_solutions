defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) do
    collatz(input, 0)
  end

  def collatz(input, _) when input < 1 do
    raise(FunctionClauseError)
  end
  def collatz(input, _) when not is_number(input) do
    raise(FunctionClauseError)
  end

  def collatz(input, count) when input == 1 do
    count
  end

  def collatz(input, count) when rem(input, 2) == 0 do
    collatz(div(input, 2), count + 1)
  end

  def collatz(input, count) do
    collatz((input * 3) + 1, count + 1)
  end
end
