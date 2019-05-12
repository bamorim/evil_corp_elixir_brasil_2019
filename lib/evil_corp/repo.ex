defmodule EvilCorp.Repo do
  use Ecto.Repo,
    otp_app: :evil_corp,
    adapter: Ecto.Adapters.Postgres
end
