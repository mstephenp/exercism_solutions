defmodule RomanNumerals do

  @ones {"I", "V", "X"}
  @tens {"X", "L", "C"}
  @hundreds {"C", "D", "M"}

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    cond do
      number < 10 ->
        get_numeral(number, @ones)
      number < 100 ->
        get_numeral(div(number, 10), @tens) <> numeral(rem(number, 10))
      number < 1000 ->
        get_numeral(div(number, 100), @hundreds) <> numeral(rem(number, 100))
      number <= 3_000 ->
        String.duplicate("M", div(number, 1000)) <> numeral(rem(number, 1000))
      end
  end

  @spec get_numeral(number(), {String.t(), String.t(), String.t()}) :: String.t()
  def get_numeral(number, {i,j,k}) do
    cond do
      number == 0 ->
        ""
      number in [1,2,3] ->
        String.duplicate(i, number)
      number == 4 ->
        i <> j
      number == 5 ->
        j
      number in [6,7,8] ->
        j <> String.duplicate(i, number - 5)
      number == 9 ->
        i <> k
    end
  end
end
