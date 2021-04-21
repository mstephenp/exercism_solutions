defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) when number == 0 do
    """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end

  def verse(number) when number == 1 do
    """
    1 bottle of beer on the wall, 1 bottle of beer.
    Take it down and pass it around, no more bottles of beer on the wall.
    """
  end

  def verse(number) do
    """
    #{number} bottles of beer on the wall, #{number} bottles of beer.
    Take one down and pass it around, #{number - 1} bottle#{pluralize?(number)} of beer on the wall.
    """
  end

  @spec pluralize?(number()) :: String.t()
  def pluralize?(number) do
    if number > 2 do
      "s"
    else
      ""
    end
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    for number <- range do
      if number == 0 or number == Enum.min(range) do
        verse(number)
      else
        verse(number) <> "\n"
      end
    end
    |> Enum.join
  end
end
