defmodule EvilCorp.Identity do
  @moduledoc """
  Handles identity related use cases such as signup.
  """

  alias EvilCorp.{
    EventDispatcher,
    EventStore,
    Identity.User,
    Identity.Events.UserSignedUp,
    Repo
  }

  require Logger

  def signup(email, name, password) do
    changeset = User.signup_changeset(%User{}, %{name: name, email: email, password: password})

    with {:ok, user} <- Repo.insert(changeset) do
      event = %UserSignedUp{
        user_id: user.id,
        name: user.name,
        email: user.email
      }

      EventStore.persist(event)
      EventDispatcher.dispatch(event)

      {:ok, user}
    end
  end
end
