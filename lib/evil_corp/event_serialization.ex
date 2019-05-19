defmodule EvilCorp.EventSerialization do
  @moduledoc """
  A simple serialization strategy.
  It would be better to use something that would encode as JSON or something like that.
  But in order to keep this simple and focus on the main purpose of the talk, I'll leave this
  as an exercise to the reader

  P.S.: Always wanted to do that. I hated when papers did that to me. Now it is my revenge. LOL
  """

  def serialize(event) do
    event
    |> :erlang.term_to_binary()
    |> Base.encode64()
  end

  def deserialize(event) do
    event
    |> Base.decode64!()
    |> :erlang.binary_to_term()
  end
end
