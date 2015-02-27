defmodule WebsocketsTermimal.Router do
  use Phoenix.Router

  socket "/ws", WebsocketsTermimal do
    channel "shell", Channels.Shell
  end

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", WebsocketsTermimal do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", WebsocketsTermimal do
  #   pipe_through :api
  # end
end
