defmodule EvilCorp.Identity.EventHandlers.AddToMailchimpListWhenUserSignedUp do
  @moduledoc "Sends an welcome email for each new user"

  alias EvilCorp.Identity.Events.UserSignedUp

  @spec handle(map()) :: :ok | {:error, any()}
  def handle(%UserSignedUp{} = event) do
    Mailchimp.add_to_list(event.email, event.name)
    :ok
  end

  def handle(_), do: :ok
end
