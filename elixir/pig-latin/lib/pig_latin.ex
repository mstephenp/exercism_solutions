defmodule PigLatin do
  @vowels ~w(a e i o u)

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(word) do
    String.split(word)
    |> Enum.map(&translate_word(&1))
    |> Enum.join(" ")
  end

  @spec translate_word(String.t()) :: String.t()
  def translate_word(word) do
    cond do
      String.starts_with?(word, ~w(x y)) && next_letter_is_consonant(word) ->
        translate_as_vowel(word)

      String.contains?(word, ~w(yt xr)) ->
        translate_as_vowel(word)

      String.first(word) in @vowels ->
        translate_as_vowel(word)

      String.contains?(word, ~w(squ thr sch)) ->
        {first_three, rest} = String.split_at(word, 3)
        translate_as_consonant(first_three, rest)

      String.contains?(word, ~w(ch qu th)) ->
        {first_pair, rest} = String.split_at(word, 2)
        translate_as_consonant(first_pair, rest)

      true ->
        {starting_consonants, rest} = split_at_first_vowel(word)
        translate_as_consonant(starting_consonants, rest)
    end
  end

  @spec split_at_first_vowel(String.t()) :: {String.t(), String.t()}
  def split_at_first_vowel(word) do
    [{_, index} | _] =
      String.split(word, "", trim: true)
      |> Enum.with_index()
      |> Enum.filter(fn {c, _i} -> c in @vowels end)

    String.split_at(word, index)
  end

  @spec next_letter_is_consonant(String.t()) :: boolean
  def next_letter_is_consonant(word) do
    String.at(word, 1) not in @vowels
  end

  @spec translate_as_vowel(String.t()) :: String.t()
  def translate_as_vowel(word), do: "#{word}ay"

  @spec translate_as_consonant(String.t(), String.t()) :: String.t()
  def translate_as_consonant(letters, rest), do: "#{rest}#{letters}ay"
end
