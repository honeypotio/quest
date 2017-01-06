defmodule QuestApi.QuestionView do
  use QuestApi.Web, :view

  attributes [:id, :code, :body]
  has_many :options, link: "/questions/:id/options"

  def render("index.json", %{questions: questions}) do
    %{data: render_many(questions, QuestApi.QuestionView, "question.json")}
  end

  def render("show.json", %{question: question}) do
    %{data: render_one(question, QuestApi.QuestionView, "question.json")}
  end

  def render("question.json", %{question: question}) do
    %{id: question.id,
      code: question.code,
      body: question.body,
      created_by: question.created_by,
      updated_by: question.updated_by}
  end
end
