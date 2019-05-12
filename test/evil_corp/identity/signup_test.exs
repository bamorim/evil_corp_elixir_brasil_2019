defmodule EvilCorp.Identity.SignupTest do
  use EvilCorp.DataCase

  alias EvilCorp.{
    Identity,
    Repo
  }

  alias Identity.{
    User,
    UserEmail
  }

  describe "signup/3" do
    setup do
      email = "email#{Enum.random(0..9999)}@example.com"
      name = "Person #{Enum.random(0..9999)}"
      password = "password#{Enum.random(0..9999)}"

      %{email: email, name: name, password: password}
    end

    test "it should insert a new user in the database", ctx do
      assert {:ok, user} = Identity.signup(ctx.email, ctx.name, ctx.password)
      assert %User{} = Repo.get(User, user.id)
    end

    test "it should send an email to the new user", ctx do
      Identity.signup(ctx.email, ctx.name, ctx.password)
      assert_delivered_email(UserEmail.welcome_email(ctx.email, ctx.name))
    end
  end
end
