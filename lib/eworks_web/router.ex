defmodule EworksWeb.Router do
  use EworksWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EworksWeb do
    pipe_through :api
  end
end
