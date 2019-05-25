defmodule EvilCorp.Identity.EventHandlers.SendWelcomeEmailWhenUserSignedUpTest do
  use EvilCorp.DataCase

  alias EvilCorp.Identity.{
    EventHandlers.SendWelcomeEmailWhenUserSignedUp,
    Events.UserSignedUp,
    UserEmail
  }

  describe "handle/1" do
    test "should send an email to the new user" do
      event = %UserSignedUp{
        user_id: Enum.random(0..9999),
        name: "name #{Enum.random(0..9999)}",
        email: "user#{Enum.random(0..9999)}@example.com"
      }

      SendWelcomeEmailWhenUserSignedUp.handle(event)

      assert_delivered_email(UserEmail.welcome_email(event.email, event.name))
    end
  end
end
