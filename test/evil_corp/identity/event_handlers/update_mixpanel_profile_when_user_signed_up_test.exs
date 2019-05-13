defmodule EvilCorp.Identity.EventHandlers.UpdateMixpanelProfileWhenUserSignedUpTest do
  use EvilCorp.DataCase

  alias EvilCorp.Identity.{
    EventHandlers.UpdateMixpanelProfileWhenUserSignedUp,
    Events.UserSignedUp
  }

  describe "handle/1" do
    test_with_mock "should update Mixpanel profile", Mixpanel, update_profile: fn _, _ -> :ok end do
      event = %UserSignedUp{
        user_id: Enum.random(0..9999),
        name: "name #{Enum.random(0..9999)}",
        email: "user#{Enum.random(0..9999)}@example.com"
      }

      UpdateMixpanelProfileWhenUserSignedUp.handle(event)
      assert_called(Mixpanel.update_profile(event.user_id, event.email))
    end
  end
end
