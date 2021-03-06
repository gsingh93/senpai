defmodule Senpai do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(__MODULE__, [], function: :run),
    ]

    opts = [strategy: :one_for_one, name: Senpai.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def run do
    {port, _} = Integer.parse(System.get_env("SENPAI_PORT"))
    {:ok, _} = Plug.Adapters.Cowboy.https Senpai.Router, [],
      port: port,
      keyfile: System.get_env("SENPAI_SSL_KEY"),
      certfile: System.get_env("SENPAI_SSL_CERT")
  end
end
