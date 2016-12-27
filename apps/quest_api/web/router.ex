defmodule QuestApi.Router do
  use QuestApi.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", QuestApi do
    pipe_through :api
  end
end
