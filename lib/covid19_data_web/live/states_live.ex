defmodule Covid19DataWeb.StatesLive do
  use Covid19DataWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    send(self(), :fetch_states)
    {:ok, assign(socket, states: [], loading: true)}
  end

  @impl true
  def handle_info(:fetch_states, socket) do
    case HTTPoison.get("https://disease.sh/v3/covid-19/states") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, states} ->
            {:noreply, assign(socket, states: states, loading: false)}

          {:error, _error} ->
            {:noreply, assign(socket, loading: false)}
        end

      {:error, _error} ->
        {:noreply, assign(socket, loading: false)}
    end
  end
end
