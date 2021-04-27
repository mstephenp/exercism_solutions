defmodule Year do
  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400
  """
  @spec leap_year?(non_neg_integer) :: boolean
  def leap_year?(year) do
    year |> is_divisible_by_4 |> but_not_by_100_unless_by_400
  end

  def is_divisible_by_4(year) do
    {year, rem(year, 4) == 0}
  end

  def but_not_by_100_unless_by_400({_, divisible_by_4}) when not divisible_by_4 do
    divisible_by_4
  end

  def but_not_by_100_unless_by_400({year, _}) do
    rem(year, 100) != 0 || rem(year, 400) == 0
  end
end
