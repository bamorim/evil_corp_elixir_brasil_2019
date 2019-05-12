defmodule EvilCorpWeb.Router do
  use EvilCorpWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EvilCorpWeb do
    pipe_through :api
  end
end
