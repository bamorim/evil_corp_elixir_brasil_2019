defmodule EvilCorp.EventDispatcherTest do
  use EvilCorp.DataCase, async: false

  import EvilCorp.EventSerialization, only: [serialize: 1]

  alias EvilCorp.{
    EventDispatcher,
    Identity.EventHandlers
  }

  @handlers [
    EventHandlers.SendWelcomeEmailWhenUserSignedUp,
    EventHandlers.AddToMailchimpListWhenUserSignedUp,
    EventHandlers.TrackMixpanelEventWhenUserSignedUp,
    EventHandlers.UpdateMixpanelProfileWhenUserSignedUp
  ]

  describe "dispatch/1" do
    test "it schedules one execution for every existing handler" do
      event = %{any: :thing}
      serialized_event = serialize(event)
      EventDispatcher.dispatch(event)

      for handler <- @handlers do
        handler_name = Atom.to_string(handler)

        assert_has_job(%{
          "event" => ^serialized_event,
          "handler" => ^handler_name
        })
      end
    end
  end
end
