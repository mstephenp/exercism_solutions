defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    keep(list, fun, [])
  end

  defp keep([], _fun, acc) do
    Enum.reverse(acc)
  end

  defp keep([head | tail], fun, acc) do
    cond do
      fun.(head) ->
        keep(tail, fun, [head | acc])

      true ->
        keep(tail, fun, acc)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    discard(list, fun, [])
  end

  defp discard([], _fun, acc) do
    Enum.reverse(acc)
  end

  defp discard([head | tail], fun, acc) do
    cond do
      not fun.(head) ->
        discard(tail, fun, [head | acc])

      true ->
        discard(tail, fun, acc)
    end
  end
end
