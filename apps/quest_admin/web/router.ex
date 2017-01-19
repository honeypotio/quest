defmodule QuestAdmin.Router do
  use QuestAdmin.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", QuestAdmin do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/questions", QuestionController
    resources "/options", OptionController
  end


  # Other scopes may use custom stacks.
  # scope "/api", QuestAdmin do
  #   pipe_through :api
  # end
end
