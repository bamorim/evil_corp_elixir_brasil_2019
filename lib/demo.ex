defmodule Demo do
  @moduledoc "Module to simplify the demoing process"

  def new do
    i = Enum.random(0..99999)
    EvilCorp.Identity.signup("email#{i}@example.com", "User #{i}", "pass#{i}")
  end
end
