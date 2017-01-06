defmodule QuestApi.Router do
  use QuestApi.Web, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/api", QuestApi do
    pipe_through :api

    resources "/questions", QuestionController, except: [:new, :edit] do
      resources "/options", OptionController, only: [:index]
    end

    resources "/options", OptionController, except: [:new, :edit]
  end
end
