defmodule Mixpanel do
  @moduledoc "An adapter interface to Mixpanel API"

  require Logger

  @spec track(String.t(), String.t()) :: any()
  def track(user_id, event) do
    Logger.info("Tracking event #{event} for User ##{user_id}")
  end

  @spec update_profile(String.t(), String.t()) :: any()
  def update_profile(user_id, email) do
    Logger.info("Updating mixpanel profile for ##{user_id} with email #{email}")
  end
end
