defmodule EvilCorp.EventDispatcherTest do
  use ExUnit.Case, async: false
  import Mock

  alias EvilCorp.{
    EventDispatcher,
    Identity.EventHandlers
  }

  describe "dispatch/1" do
    test "it dispatches to all event dispatchers" do
      event = %{anything: true}

      with_mocks([
        {EventHandlers.SendWelcomeEmailWhenUserSignedUp, [], [handle: fn _ -> :ok end]},
        {EventHandlers.AddToMailchimpListWhenUserSignedUp, [], [handle: fn _ -> :ok end]},
        {EventHandlers.TrackMixpanelEventWhenUserSignedUp, [], [handle: fn _ -> :ok end]},
        {EventHandlers.UpdateMixpanelProfileWhenUserSignedUp, [], [handle: fn _ -> :ok end]}
      ]) do
        EventDispatcher.dispatch(event)

        assert_called(EventHandlers.SendWelcomeEmailWhenUserSignedUp.handle(event))
        assert_called(EventHandlers.AddToMailchimpListWhenUserSignedUp.handle(event))
        assert_called(EventHandlers.TrackMixpanelEventWhenUserSignedUp.handle(event))
        assert_called(EventHandlers.UpdateMixpanelProfileWhenUserSignedUp.handle(event))
      end
    end
  end
end
