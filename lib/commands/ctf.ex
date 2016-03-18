defmodule Senpai.Command.CTF do
  @behaviour Senpai.Command

  def handle(conn) do
    Senpai.Command.send_response(conn, :in_channel, "CTF command")
  end
end
