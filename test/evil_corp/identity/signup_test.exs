defmodule EvilCorp.Identity.SignupTest do
  use EvilCorp.DataCase, async: false

  alias EvilCorp.{
    EventDispatcher,
    Identity,
    Repo
  }

  alias Identity.{
    Events.UserSignedUp,
    User
  }

  describe "signup/3" do
    setup_with_mocks([{EventDispatcher, [], [dispatch: fn _ -> :ok end]}]) do
      email = "email#{Enum.random(0..9999)}@example.com"
      name = "Person #{Enum.random(0..9999)}"
      password = "password#{Enum.random(0..9999)}"

      %{email: email, name: name, password: password}
    end

    test "should insert a new user in the database", ctx do
      assert {:ok, user} = Identity.signup(ctx.email, ctx.name, ctx.password)
      assert %User{} = Repo.get(User, user.id)
    end

    test "it should dispatch an user signed up event", ctx do
      assert {:ok, user} = Identity.signup(ctx.email, ctx.name, ctx.password)

      assert_called(
        EventDispatcher.dispatch(%UserSignedUp{
          user_id: user.id,
          email: ctx.email,
          name: ctx.name
        })
      )
    end
  end
end
