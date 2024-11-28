defmodule Covid19DataWeb.ErrorJSONTest do
  use Covid19DataWeb.ConnCase, async: true

  test "renders 404" do
    assert Covid19DataWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert Covid19DataWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
