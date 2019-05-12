defmodule EvilCorp.Identity do
  @moduledoc """
  Handles identity related use cases such as signup.
  """

  alias EvilCorp.{
    Identity.User,
    Identity.UserEmail,
    Mailer,
    Repo
  }

  require Logger

  def signup(email, name, password) do
    changeset = User.signup_changeset(%User{}, %{name: name, email: email, password: password})

    with {:ok, user} <- Repo.insert(changeset) do
      send_welcome_email(user)
      Mailchimp.add_to_list(user.email, user.name)
      Mixpanel.track(user.id, "$signup")
      Mixpanel.update_profile(user.id, user.email)
      {:ok, user}
    end
  end

  defp send_welcome_email(user) do
    user.email
    |> UserEmail.welcome_email(user.name)
    |> Mailer.deliver_now()
  end
end
