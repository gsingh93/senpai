defmodule Senpai.Router do
  use Plug.Router

  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug :match
  plug :dispatch

  @spec commands :: %{atom => Senpai.Command}
  def commands do
    %{ctf: Senpai.Command.CTF}
  end

  get "/:command" do
    cmds = commands()
    module = cmds[String.to_atom(command)]
    if module == nil do
      send_resp(conn, 404, "No handler for command #{command}")
    else
      try do
        module.handle(conn)
      rescue
        e in RuntimeError -> send_resp(conn, 200, "Exception occured: #{Exception.message(e)}")
      end
    end
  end

  get "/" do
    send_resp(conn, 404, "No command specified")
  end
end
