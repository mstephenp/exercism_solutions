defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    isbn
    |> String.split("", trim: true)
    |> Enum.filter(fn c -> c != "-" end)
    |> Enum.map(fn c -> if c == "X", do: "10", else: c end)
    |> Enum.map(fn c -> Integer.parse(c) end)
    |> Enum.filter(fn n -> n != :error end)
    |> Enum.map(fn {n, _} -> n end)
    |> verify()
  end

  def verify([x1, x2, x3, x4, x5, x6, x7, x8, x9, x10]) do
    (x1 * 10 +
       x2 * 9 +
       x3 * 8 +
       x4 * 7 +
       x5 * 6 +
       x6 * 5 +
       x7 * 4 +
       x8 * 3 +
       x9 * 2 +
       x10 * 1)
    |> rem(11) == 0
  end

  def verify(_anything_else) do
    false
  end
end
