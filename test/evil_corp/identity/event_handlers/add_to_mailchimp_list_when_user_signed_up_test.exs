defmodule EvilCorp.Identity.EventHandlers.AddToMailchimpListWhenUserSignedUpTest do
  use EvilCorp.DataCase

  alias EvilCorp.Identity.{
    EventHandlers.AddToMailchimpListWhenUserSignedUp,
    Events.UserSignedUp
  }

  describe "handle/1" do
    test_with_mock "should add user to mailchimp list on user event", Mailchimp,
      add_to_list: fn _, _ -> :ok end do
      event = %UserSignedUp{
        user_id: Enum.random(0..9999),
        name: "name #{Enum.random(0..9999)}",
        email: "user#{Enum.random(0..9999)}@example.com"
      }

      AddToMailchimpListWhenUserSignedUp.handle(event)
      assert_called(Mailchimp.add_to_list(event.email, event.name))
    end
  end
end
