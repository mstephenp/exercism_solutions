defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    String.split(string, "", trim: true)
    |> Enum.frequencies
    |> Enum.map(fn {k,v} ->
      if v == 1 do
        "#{k}"
      else
        "#{v}#{k}"
      end
    end)
    |> Enum.join
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    letters = IO.inspect String.split(string, ~r(\d), trim: true)
    numbers = IO.inspect String.split(string, ~r(\D), trim: true)

    {l, n} = find_single_letters(letters)
    |> Enum.filter(&(&1 != nil))
    |> split_single_letters(letters, numbers)

    Enum.zip(n, l)
    |> Enum.map(fn {n, l} -> String.duplicate(l, String.to_integer(n)) end)
    |> Enum.join

  end

  @spec find_single_letters([String.t()]) :: list
  def find_single_letters(letters) do
    for {l, idx} <- Enum.with_index(letters) do
      if String.length(l) > 1 do
        (idx + 1)..idx + (String.length(l) - 1)
      end
    end
  end

  @spec split_single_letters([number()], [String.t()], [number]) :: {list, list}
  def split_single_letters(indexes, letters, numbers) do
    split_letters = Enum.map(indexes, fn i ->
      List.update_at(letters, i, fn s ->
        String.split(s, "", trim: true)
      end)
    end)
    |> List.flatten
    |> Enum.filter(fn s -> String.length(s) < 2 end)

    split_numbers = Enum.map(indexes, fn i ->
      List.insert_at(numbers, i + 1, "1")
    end)
    |> List.flatten

    {split_letters, split_numbers}
  end
end
