defmodule QuestAdmin.PageControllerTest do
  use QuestAdmin.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Quest!"
  end
end
