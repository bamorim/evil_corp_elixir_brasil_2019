defmodule EvilCorp.EventStore do
  alias EvilCorp.{
    EventStore.Event,
    Repo
  }

  def persist(event) do
    event
    |> Event.from_event()
    |> Repo.insert!()
  end

  def all do
    Event
    |> Repo.all()
    |> Enum.map(&Event.to_event/1)
  end
end
