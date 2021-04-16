defmodule Bob do


  def hey(input) do
    cond do
      is_silence?(input) ->
        "Fine. Be that way!"

      is_yelling_question?(input) ->
        "Calm down, I know what I'm doing!"

      is_just_a_question?(input) ->
        "Sure."

      is_all_caps?(input) ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end


  @spec is_yelling_question?(binary) :: boolean
  def is_yelling_question?(input) do
    String.ends_with?(String.trim(input), "?") &&
      String.upcase(String.trim(input)) == input &&
      Integer.parse(String.trim_trailing(input, "?")) == :error
  end

  @spec is_just_a_question?(binary) :: boolean
  def is_just_a_question?(input) do
    String.ends_with?(String.trim(input), "?")
  end

  @spec is_all_caps?(binary) :: boolean
  def is_all_caps?(input) do
    String.upcase(input) == input &&
    Integer.parse(String.trim_trailing(input, "?")) != :error
  end

  @spec is_silence?(binary) :: boolean
  def is_silence?(input) do
    String.length(String.trim(input)) == 0
  end
end
