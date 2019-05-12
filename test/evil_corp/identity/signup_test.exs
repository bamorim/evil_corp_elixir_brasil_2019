defmodule EvilCorp.Identity.SignupTest do
  use EvilCorp.DataCase, async: false

  alias EvilCorp.{
    Identity,
    Repo
  }

  alias Identity.{
    User,
    UserEmail
  }

  describe "signup/3" do
    setup_with_mocks([
      {Mixpanel, [],
       [
         track: fn _, _ -> :ok end,
         update_profile: fn _, _ -> :ok end
       ]},
      {Mailchimp, [],
       [
         add_to_list: fn _, _ -> :ok end
       ]}
    ]) do
      email = "email#{Enum.random(0..9999)}@example.com"
      name = "Person #{Enum.random(0..9999)}"
      password = "password#{Enum.random(0..9999)}"

      %{email: email, name: name, password: password}
    end

    test "should insert a new user in the database", ctx do
      assert {:ok, user} = Identity.signup(ctx.email, ctx.name, ctx.password)
      assert %User{} = Repo.get(User, user.id)
    end

    test "should send an email to the new user", ctx do
      Identity.signup(ctx.email, ctx.name, ctx.password)
      assert_delivered_email(UserEmail.welcome_email(ctx.email, ctx.name))
    end

    test "should update Mixpanel profile", ctx do
      {:ok, user} = Identity.signup(ctx.email, ctx.name, ctx.password)
      assert_called(Mixpanel.update_profile(user.id, ctx.email))
    end

    test "should register a signup event on Mixpanel", ctx do
      {:ok, user} = Identity.signup(ctx.email, ctx.name, ctx.password)
      assert_called(Mixpanel.track(user.id, "$signup"))
    end
  end
end
