defmodule EvilCorp.Identity.EventHandlers.TrackMixpanelEventWhenUserSignedUpTest do
  use EvilCorp.DataCase

  alias EvilCorp.Identity.{
    EventHandlers.TrackMixpanelEventWhenUserSignedUp,
    Events.UserSignedUp
  }

  describe "handle/1" do
    test_with_mock "should register a signup event on Mixpanel", Mixpanel,
      track: fn _, _ -> :ok end do
      event = %UserSignedUp{
        user_id: Enum.random(0..9999),
        name: "name #{Enum.random(0..9999)}",
        email: "user#{Enum.random(0..9999)}@example.com"
      }

      TrackMixpanelEventWhenUserSignedUp.handle(event)
      assert_called(Mixpanel.track(event.user_id, "$signup"))
    end
  end
end
