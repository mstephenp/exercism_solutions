defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    if length(strand) == 0 do
      0
    else
      Enum.frequencies(strand)[nucleotide]
    end
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do
    freq = Enum.frequencies(strand)

    Enum.reduce(@nucleotides, %{},
      fn n, acc ->
        if freq[n] == nil do
          Map.put(acc, n, 0)
        else
          Map.put(acc, n, freq[n])
        end
      end)


  end
end
