defmodule EvilCorp.Identity.EventHandlers.UpdateMixpanelProfileWhenUserSignedUp do
  @moduledoc "Sends an welcome email for each new user"

  alias EvilCorp.Identity.Events.UserSignedUp

  @spec handle(map()) :: :ok | {:error, any()}
  def handle(%UserSignedUp{} = event) do
    Mixpanel.update_profile(event.user_id, event.email)
  end

  def handle(_), do: :ok
end
