defmodule Acronym do

  @caps Enum.map(?A..?Z, &(<<&1 :: utf8>>))

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    String.split(string, [" ", " - ", "-"])
    |> Enum.map(&(String.trim(&1, "_")))
    |> find_inconsistent_case()
    |> List.flatten
    |> Enum.map(&(String.at(&1, 0)))
    |> Enum.map(&String.upcase/1)
    |> Enum.join
  end

  @spec find_inconsistent_case([String.t()]) :: [String.t()]
  def find_inconsistent_case(words) do
    for word <- words do
      [head | rest] = String.split(word, "", trim: true)
      if contains_inconsistent_case(rest) do
        split_word_at_cap(String.downcase(head) <> Enum.join rest)
      else
        word
      end
    end
  end

  @spec contains_inconsistent_case(any) :: boolean
  def contains_inconsistent_case(word) do
    cases = Enum.map(word, &(&1 in @caps)) |> Enum.filter(&(&1))
    length(cases) > 0 and not (length(word) == length(cases))
  end

  @spec split_word_at_cap(String.t()) :: list
  def split_word_at_cap(word) do
    Enum.with_index(String.split(word, "", trim: true))
    |> Enum.filter(fn {a,_} -> a in @caps end)
    |> Enum.map(fn {_, b} -> b end)
    |> Enum.map(&(String.split_at(word, &1)))
    |> Enum.map(fn {a,b} -> [String.capitalize(a), String.capitalize(b)] end)
    |> List.flatten
  end
end
