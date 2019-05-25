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
      pid = self()

      mock_for = fn mod ->
        {mod, [],
         [
           handle: fn evt ->
             send(pid, {:handled, mod, evt})
             :ok
           end
         ]}
      end

      with_mocks([
        mock_for.(EventHandlers.SendWelcomeEmailWhenUserSignedUp),
        mock_for.(EventHandlers.AddToMailchimpListWhenUserSignedUp),
        mock_for.(EventHandlers.TrackMixpanelEventWhenUserSignedUp),
        mock_for.(EventHandlers.UpdateMixpanelProfileWhenUserSignedUp)
      ]) do
        EventDispatcher.dispatch(event)

        assert_receive({:handled, EventHandlers.SendWelcomeEmailWhenUserSignedUp, ^event})
        assert_receive({:handled, EventHandlers.AddToMailchimpListWhenUserSignedUp, ^event})
        assert_receive({:handled, EventHandlers.TrackMixpanelEventWhenUserSignedUp, ^event})
        assert_receive({:handled, EventHandlers.UpdateMixpanelProfileWhenUserSignedUp, ^event})
      end
    end
  end
end
