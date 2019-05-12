defmodule Mailchimp do
  @moduledoc "An adapter interface to Mailchimp API"

  require Logger

  @spec add_to_list(String.t(), String.t()) :: any()
  def add_to_list(email, name) do
    Logger.info("Adding #{email} (#{name}) to marketing list")
  end
end
