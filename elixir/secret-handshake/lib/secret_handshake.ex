defmodule SecretHandshake do

  @codes [
    "reverse", "jump", "close your eyes", "double blink", "wink"
  ]

  def commands(code) when code > 31 or code < 1 do
    []
  end

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do

    cmds = Integer.to_string(code, 2)
    |> String.split("", trim: true)
    |> Enum.map(&(String.to_integer(&1)))
    |> zero_pad()
    |> Enum.zip(@codes)
    |> Enum.map(fn {a,b} -> {b,a} end)
    |> Enum.filter(fn {_,b} -> b == 1 end)
    |> Enum.map(fn {a,_} -> a end)

    [head | tail] = cmds

    if head == "reverse" do
      tail
    else
      Enum.reverse(cmds)
    end
  end

  defp zero_pad(code) when length(code) < 5 do
    [List.duplicate(0, 5 - length(code)) | code] |> List.flatten
  end

  defp zero_pad(code) do
    code
  end

end
