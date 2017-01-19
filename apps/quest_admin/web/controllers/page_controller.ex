defmodule QuestAdmin.PageController do
  use QuestAdmin.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
