defmodule QuestApi.OptionView do
  use QuestApi.Web, :view
  attributes [:code, :body, :question_id]

  def render("index.json", %{options: options}) do
    %{data: render_many(options, QuestApi.OptionView, "option.json")}
  end

  def render("show.json", %{option: option}) do
    %{data: render_one(option, QuestApi.OptionView, "option.json")}
  end

  def render("option.json", %{option: option}) do
    %{id: option.id,
      code: option.code,
      body: option.body,
      created_by: option.created_by,
      updated_by: option.updated_by,
      question_id: option.question_id}
  end
end
