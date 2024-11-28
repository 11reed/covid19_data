defmodule Covid19DataWeb.CountriesLive do
  use Covid19DataWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    send(self(), :fetch_countries)
    {:ok, assign(socket, countries: [], loading: true)}
  end

  @impl true
  def handle_info(:fetch_countries, socket) do
    case HTTPoison.get("https://disease.sh/v3/covid-19/countries") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, countries} ->
            {:noreply, assign(socket, countries: countries, loading: false)}

          {:error, _error} ->
            {:noreply, assign(socket, loading: false)}
        end

      {:error, _error} ->
        {:noreply, assign(socket, loading: false)}
    end
  end
end
