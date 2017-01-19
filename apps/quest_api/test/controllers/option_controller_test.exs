defmodule QuestApi.OptionControllerTest do
  use QuestApi.ConnCase

  alias QuestApi.Question
  alias QuestApi.Option

  @question_attrs %Question{code: "XYZQA", body: "What is the best programming language?"}
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
    conn = get conn, question_option_path(conn, :index, 42)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    option = Repo.insert! %Option{}
    conn = get conn, option_path(conn, :show, option)
    assert json_response(conn, 200)["data"] == %{"id" => Integer.to_string(option.id),
      "type" => "option",
      "attributes" => %{
        "code" => option.code,
        "body" => option.body,
        "question-id" => option.question_id
      }
    }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, option_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    question = Repo.insert!(@question_attrs)
    conn = conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")
      |> post(option_path(conn, :create), option: Map.put(@valid_attrs, :question_id, question.id))
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Option, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, option_path(conn, :create), option: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    question = Repo.insert!(@question_attrs)
    option = Ecto.build_assoc(question, :options, Map.put(@valid_attrs, :question_id, question.id))
              |> Repo.insert!
    conn = put conn, option_path(conn, :update, option), option: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Option, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    option = Repo.insert! %Option{}
    conn = put conn, option_path(conn, :update, option), option: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    option = Repo.insert! %Option{}
    conn = delete conn, option_path(conn, :delete, option)
    assert response(conn, 204)
    refute Repo.get(Option, option.id)
  end
end
