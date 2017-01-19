defmodule QuestAdmin.OptionTest do
  use QuestAdmin.ModelCase

  alias QuestAdmin.Option

  @valid_attrs %{body: "some content", code: "some content", created_by: 42, updated_by: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Option.changeset(%Option{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Option.changeset(%Option{}, @invalid_attrs)
    refute changeset.valid?
  end
end
