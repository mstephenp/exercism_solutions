defmodule PigLatin do

  @vowels ~w(a e i o u yt xr x)
  @consonant_group ~w(ch qu squ thr th sch)
  @x_or_y ~w(x y)


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

    {first_letter, rest} = String.split_at(word, 1)

    cond do
      # String.contains?(word, ~w(ch qu squ thr th sch)) ->

      first_letter in ~w(a e i o u x) ->
        "#{word}ay"

      true ->
        "#{rest}#{first_letter}ay"
    end


    # translated_words = for word <- String.split(phrase) do
    #   translate_word(word)
    # end

    # Enum.join(translated_words, " ")

  end

  def translate_word(word) do
    vowel_start = starts_with(@vowels, word)
    cons_grp_start = starts_with(@consonant_group, word)
    x_or_y_start = starts_with(@x_or_y, word) |> next_is_consonant()

    cond do
      vowel_start ->
        "#{word}ay"
      cons_grp_start ->

        # {start, fin} = String.split_at(word, String.length(cons_grp_start))
        {start, fin} = get_starting_consonants("", word)
        "#{fin}#{start}ay"

      x_or_y_start ->
        "#{word}ay"

      !vowel_start ->
        {start, fin} = get_starting_consonants("", word)
        "#{fin}#{start}ay"

      true ->
        [start | fin] = String.split(word, "", trim: true)
        "#{Enum.join(fin)}#{start}ay"
      end
  end


  @spec starts_with([String.t()], String.t()) :: String.t | boolean()
  def starts_with(group, phrase) do
    Enum.find(group, false, &(String.starts_with?(phrase, &1)))
  end

  def next_is_consonant(letters) when not letters do
    letters
  end

  def next_is_consonant(letters) do
    !starts_with(@vowels, letters) or starts_with(@consonant_group, letters)
  end

  @spec get_starting_consonants(String.t(), String.t()) :: {String.t(), String.t()}
  def get_starting_consonants(letters, word) do
    IO.inspect letters
    IO.inspect word
    if !starts_with(@vowels, word) or starts_with(@consonant_group, word) do
      if starts_with(@consonant_group, word) do
        {first_letter, rest} = String.split_at(word, 2)
        get_starting_consonants(letters <> first_letter, rest)
      else
        {first_letter, rest} = String.split_at(word, 1)
        get_starting_consonants(letters <> first_letter, rest)
      end
    else
      {letters, word}
    end
  end
end
