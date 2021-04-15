defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    String.replace(sentence, ["-", " "], "")
    |> String.split("", trim: true)
    |> Enum.frequencies
    |> Enum.filter(fn {_,v} -> v != 1 end)
    |> length() == 0
  end
end
