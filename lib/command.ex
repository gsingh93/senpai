defmodule Senpai.Command do
  import Plug.Conn

  @callback handle(Plug.Conn.t) :: Plug.Conn.t | no_return

  def send_response(conn, response_type, text, attachment \\ nil) do
    response_type = case response_type do
      :in_channel -> "in_channel"
      :ephemeral -> "ephemeral"
      _ -> raise "Invalid response type: #{response_type}"
    end
    response = %{response_type: response_type, text: text}
    if attachment != nil do
      Map.put(response, :attachment, attachment)
    end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(response))
  end
end
