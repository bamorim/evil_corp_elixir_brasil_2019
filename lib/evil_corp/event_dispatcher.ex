defmodule EvilCorp.EventDispatcher do
  @moduledoc "Dispatch an event to all handlers"

  alias EvilCorp.Identity.EventHandlers

  @spec dispatch(map()) :: :ok
  def dispatch(event) do
    for handler <- handlers() do
      Task.async(fn ->
        :ok = handler.handle(event)
      end)
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
