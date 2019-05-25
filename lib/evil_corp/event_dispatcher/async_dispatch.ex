defmodule EvilCorp.EventDispatcher.AsyncDispatch do
  @moduledoc """
  Obs: It would probably be better to transform each event handler in a job, but I didn't wanted to
  give a talk about a specific job queue.
  """

  use Oban.Worker
  import EvilCorp.EventSerialization

  @impl Oban.Worker
  def perform(%{"event" => serialized_event, "handler" => handler_atom_as_string}) do
    :ok = String.to_existing_atom(handler_atom_as_string).handle(deserialize(serialized_event))
  end

  def dispatch(handler, event) do
    %{event: serialize(event), handler: Atom.to_string(handler)}
    |> Oban.Job.new(queue: :default, worker: EvilCorp.EventDispatcher.AsyncDispatch)
    |> EvilCorp.Repo.insert!()
  end
end
