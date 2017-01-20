defmodule QuestWeb.PageController do
  use QuestWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
