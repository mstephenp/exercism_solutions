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
    String.split(isbn, "", trim: true)
    |> Enum.filter(&(&1 != "-"))
    |> Enum.map(&change_x/1)
    |> Enum.map(&Integer.parse/1)
    |> verify()
  end

  def change_x(value) when value == "X" do
    "10"
  end

  def change_x(value) do
    value
  end

  def verify(isbn_numbers) when length(isbn_numbers) != 10 do
    false
  end

  def verify(isbn_numbers) do
    Enum.filter(isbn_numbers, &(&1 != :error))
    |> Enum.map(fn {n, _} -> n end)
    |> is_valid?()
  end

  def is_valid?([x1, x2, x3, x4, x5, x6, x7, x8, x9, x10]) do
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

  def is_valid?(_anything_else) do
    false
  end
end
