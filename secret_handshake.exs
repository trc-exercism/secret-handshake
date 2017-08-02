use Bitwise, only_operators: true

defmodule SecretHandshake do
  @action_values [1, 2, 4, 8]
  @actions %{1 => "wink", 2 => "double blink", 4 => "close your eyes", 8 => "jump"}

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
    cond do
      (code &&& 16) == 16 -> Enum.reverse(get_commands(code))
      true -> get_commands(code)
    end
  end

  defp get_commands(code) do
    @action_values
      |> Enum.filter(fn(action_value) -> (action_value &&& code) == action_value end)
      |> Enum.map(fn(action_value) -> @actions[action_value] end)
  end
end
