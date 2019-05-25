defmodule EvilCorp.EventStore.Event do
  @moduledoc """
  You may want to have the user_id extracted somewhere else so you can easily list events for a
  given user, but in order to keep this example simple, I'll leave that as it is.
  """

  use Ecto.Schema
  import EvilCorp.EventSerialization

  schema "events" do
    field :data, :string

    timestamps()
  end

  @doc "Converts an user event to the user schema entry"
  def from_event(event) do
    %__MODULE__{data: serialize(event)}
  end

  def to_event(entry) do
    deserialize(entry.data)
  end
end
