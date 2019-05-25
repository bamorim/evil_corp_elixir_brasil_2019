defmodule EvilCorp.Identity.EventHandlers.TrackMixpanelEventWhenUserSignedUp do
  @moduledoc "Sends an welcome email for each new user"

  alias EvilCorp.Identity.Events.UserSignedUp

  @spec handle(map()) :: :ok | {:error, any()}
  def handle(%UserSignedUp{} = event) do
    Mixpanel.track(event.user_id, "$signup")
  end

  def handle(_), do: :ok
end
