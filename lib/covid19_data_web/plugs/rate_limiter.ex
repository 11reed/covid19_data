defmodule MyAppWeb.Plugs.RateLimiter do
  @moduledoc """
  A Plug to rate limit incoming requests based on the client's IP address.
  """

  import Plug.Conn
  alias Hammer

  def init(opts), do: opts

  def call(conn, _opts) do
    ip_address = Tuple.to_list(conn.remote_ip) |> Enum.join(".")

    case Hammer.check_rate("rate:#{ip_address}", 60_000, 100) do
      {:allow, _count} ->
        conn

      {:deny, _limit} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(429, ~s({"error": "Too many requests"}))
        |> halt()
    end
  end
end
