defmodule QuestAdmin.QuestionTest do
  use QuestAdmin.ModelCase

  alias QuestAdmin.Question

  @valid_attrs %{body: "some content", code: "some content", created_by: 42, updated_by: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Question.changeset(%Question{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Question.changeset(%Question{}, @invalid_attrs)
    refute changeset.valid?
  end
end
