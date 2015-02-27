defmodule WebsocketsTermimal.Endpoint do
  use Phoenix.Endpoint, otp_app: :websockets_termimal

  # Serve at "/" the given assets from "priv/static" directory
  plug Plug.Static,
    at: "/", from: :websockets_termimal,
    only: ~w(css images components js favicon.ico robots.txt)

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_websockets_termimal_key",
    signing_salt: "UOczEFan",
    encryption_salt: "F6xdbaNr"

  plug :router, WebsocketsTermimal.Router
end
