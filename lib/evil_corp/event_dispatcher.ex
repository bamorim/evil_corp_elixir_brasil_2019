defmodule EvilCorp.EventDispatcher do
  @moduledoc "Dispatch an event to all handlers"

  alias EvilCorp.Identity.EventHandlers
  import EvilCorp.EventSerialization, only: [serialize: 1]

  @spec dispatch(map()) :: :ok
  def dispatch(event) do
    for handler <- handlers() do
      %{event: serialize(event), handler: Atom.to_string(handler)}
      |> Oban.Job.new(queue: :default, worker: EvilCorp.EventDispatcher.AsyncDispatch)
      |> EvilCorp.Repo.insert!()
    end

    :ok
  end

  defp handlers do
    [
      EventHandlers.SendWelcomeEmailWhenUserSignedUp,
      EventHandlers.AddToMailchimpListWhenUserSignedUp,
      EventHandlers.TrackMixpanelEventWhenUserSignedUp,
      EventHandlers.UpdateMixpanelProfileWhenUserSignedUp
    ]
  end
end
