defmodule Covid19DataWeb.HomeLive do
  use Covid19DataWeb, :live_view

  import Covid19DataWeb.Layouts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
