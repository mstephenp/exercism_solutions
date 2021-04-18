defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      is_silence?(input) ->
        "Fine. Be that way!"

      is_just_a_question?(input) && is_only_numbers?(input) ->
        "Sure."

      is_yelling_question?(input) ->
        "Calm down, I know what I'm doing!"

      is_just_a_question?(input) ->
        "Sure."

      is_only_numbers?(input) ->
        "Whatever."

      is_all_caps?(input) ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end

  @spec is_yelling_question?(binary) :: boolean
  def is_yelling_question?(input) do
    String.ends_with?(String.trim(input), "?") &&
      String.upcase(String.trim(input)) == input
  end

  @spec is_just_a_question?(binary) :: boolean
  def is_just_a_question?(input) do
    String.ends_with?(String.trim(input), "?")
  end

  @spec is_all_caps?(binary) :: boolean
  def is_all_caps?(input) do
    String.upcase(input) == input
  end

  @spec is_silence?(binary) :: boolean
  def is_silence?(input) do
    String.length(String.trim(input)) == 0
  end

  @spec is_only_numbers?(String.t()) :: boolean
  def is_only_numbers?(input) do
    String.split(input, ~r/[^[:alnum:]-]/u, trim: true)
    |> Enum.filter(fn letter -> letter not in ~w(, - _) end)
    |> Enum.filter(fn letter -> Integer.parse(letter) == :error end)
    |> length == 0
  end
end
