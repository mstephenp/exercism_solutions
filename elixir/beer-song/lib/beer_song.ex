defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(0) do
    """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end

  def verse(1) do
    """
    1 bottle of beer on the wall, 1 bottle of beer.
    Take it down and pass it around, no more bottles of beer on the wall.
    """
  end

  def verse(2) do
    """
    2 bottles of beer on the wall, 2 bottles of beer.
    Take one down and pass it around, 1 bottle of beer on the wall.
    """
  end

  def verse(number) do
    """
    #{number} bottles of beer on the wall, #{number} bottles of beer.
    Take one down and pass it around, #{number - 1} bottles of beer on the wall.
    """
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    for number <- range do
      if number == Enum.min(range) do
        verse(number)
      else
        verse(number) <> "\n"
      end
    end
    |> Enum.join()
  end

  # @spec verse(number) :: <<_::64, _::_*8>>
  # def verse(number) do
  #   to_string(amount(number)) <>
  #     " bottle" <>
  #     plural?(number) <>
  #     " of beer on the wall, " <>
  #     to_string(amount(number, last: true)) <>
  #     " bottle" <>
  #     plural?(number) <>
  #     " of beer.\n" <>
  #     take_or_store(number) <>
  #     " bottle" <>
  #     plural?(number, last: true) <>
  #     " of beer on the wall.\n"
  # end

  # @spec amount(any, any) :: any
  # def amount(number, last \\ false) do
  #   cond do
  #     number == 0 && last ->
  #       "no more"

  #     number == 0 ->
  #       "No more"

  #     true ->
  #       number
  #   end
  # end

  # @spec take_or_store(number()) :: String.t()
  # def take_or_store(number) do
  #   cond do
  #     number == 0 ->
  #       "Go to the store and buy some more, 99"

  #     number == 1 ->
  #       "Take it down and pass it around, no more"

  #     true ->
  #       "Take one down and pass it around, #{number - 1}"
  #   end
  # end

  # @spec plural?(any, any) :: binary
  # def plural?(number, last \\ false) do
  #   cond do
  #     number == 2 and last ->
  #       ""

  #     number == 1 and last ->
  #       "s"

  #     number > 1 or number == 0 ->
  #       "s"

  #     true ->
  #       ""
  #   end
  # end
end
