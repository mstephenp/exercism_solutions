defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    count(l, 0)
  end

  defp count([], n) do
    n
  end

  defp count([_ | tail], n) do
    count(tail, n + 1)
  end

  @spec reverse(list) :: list
  def reverse([]) do
    []
  end

  def reverse([head | tail]) do
    reverse(tail, [head | []])
  end

  @spec reverse(list, any) :: any
  def reverse([], acc) do
    acc
  end

  def reverse([head | tail], acc) do
    reverse(tail, [head | acc])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    for i <- l do
      f.(i)
    end
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _f) do
    []
  end

  def filter(l, f) do
    filter(l, f, [])
  end

  @spec filter(list, (any -> as_boolean(term)), any) :: any
  def filter([], _f, acc) do
    reverse(acc)
  end

  def filter([head | tail], f, acc) do
    if f.(head) == true do
      filter(tail, f, [head | acc])
    else
      filter(tail, f, acc)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f) do
    acc
  end

  def reduce([head | tail], acc, f) do
    reduce(tail, f.(head, acc), f)
  end

  @spec append(list, list) :: list
  def append([], b) do
    b
  end

  def append(a, []) do
    a
  end

  def append(a, [head | tail]) do
    append(reverse([head | reverse(a)]), tail)
  end

  @spec concat([[any]]) :: [any]
  def concat([]) do
    []
  end

  def concat([head | tail]) do
    concat(head, tail, [])
  end

  def concat(l, [], acc) do
    append(acc, l)
  end

  def concat(l, [head | tail], acc) do
    concat(head, tail, append(acc, l))
  end
end
