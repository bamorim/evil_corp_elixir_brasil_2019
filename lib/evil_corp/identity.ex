defmodule EvilCorp.Identity do
  @moduledoc """
  Handles identity related use cases such as signup.
  """

  alias EvilCorp.{
    EventDispatcher,
    Identity.User,
    Identity.Events.UserSignedUp,
    Repo
  }

  require Logger

  def signup(email, name, password) do
    changeset = User.signup_changeset(%User{}, %{name: name, email: email, password: password})

    with {:ok, user} <- Repo.insert(changeset) do
      Mixpanel.track(user.id, "$signup")
      Mixpanel.update_profile(user.id, user.email)
      EventDispatcher.dispatch(%UserSignedUp{
        user_id: user.id,
        name: user.name,
        email: user.email
      })

      {:ok, user}
    end
  end
end
