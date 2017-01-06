defmodule QuestApi.QuestionControllerTest do
  use QuestApi.ConnCase

  alias QuestApi.Question
  @valid_attrs %{body: "some content", code: "some content", created_by: 42, updated_by: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, question_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    question = Repo.insert! %Question{}
    conn = get conn, question_path(conn, :show, question)
    assert json_response(conn, 200)["data"] == %{
      "id" => Integer.to_string(question.id),
      "attributes" => %{
        "code" => question.code,
        "body" => question.body,
        "id" => question.id
      },
      "relationships" => %{
        "options" => %{
          "links" => %{
            "related" => "/questions/#{question.id}/options"
          }
        }
      },
      "type" => "question"
    }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, question_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, question_path(conn, :create), question: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Question, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, question_path(conn, :create), question: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    question = Repo.insert! %Question{}
    conn = put conn, question_path(conn, :update, question), question: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Question, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    question = Repo.insert! %Question{}
    conn = put conn, question_path(conn, :update, question), question: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    question = Repo.insert! %Question{}
    conn = delete conn, question_path(conn, :delete, question)
    assert response(conn, 204)
    refute Repo.get(Question, question.id)
  end
end
