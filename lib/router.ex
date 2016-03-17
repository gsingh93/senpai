defmodule Senpai.Router do
  use Plug.Router

  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "This entire website runs on Elixir plugs!")
  end
end
