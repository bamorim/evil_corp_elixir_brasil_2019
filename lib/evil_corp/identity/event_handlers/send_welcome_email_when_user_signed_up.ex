defmodule EvilCorp.Identity.EventHandlers.SendWelcomeEmailWhenUserSignedUp do
  @moduledoc "Sends an welcome email for each new user"

  alias EvilCorp.{
    Identity.Events.UserSignedUp,
    Identity.UserEmail,
    Mailer
  }

  @spec handle(map()) :: :ok
  def handle(%UserSignedUp{} = event) do
    event.email
    |> UserEmail.welcome_email(event.name)
    |> Mailer.deliver_now()

    :ok
  end

  def handle(_), do: :ok
end
