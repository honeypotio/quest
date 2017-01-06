defmodule QuestApi.OptionController do
  use QuestApi.Web, :controller

  alias QuestApi.Option

  def index(conn, %{"question_id" => question_id}) do
    options = Repo.all(from o in Option, where: o.question_id == ^question_id)
    render(conn, "index.json-api", data: options)
  end

  def create(conn, %{"option" => option_params}) do
    changeset = Option.changeset(%Option{}, option_params)

    case Repo.insert(changeset) do
      {:ok, option} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", option_path(conn, :show, option))
        |> render("show.json-api", data: option)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(QuestApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    option = Repo.get!(Option, id)
    render(conn, "show.json-api", data: option)
  end

  def update(conn, %{"id" => id, "option" => option_params}) do
    option = Repo.get!(Option, id)
    changeset = Option.changeset(option, option_params)

    case Repo.update(changeset) do
      {:ok, option} ->
        render(conn, "show.json-api", data: option)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(QuestApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    option = Repo.get!(Option, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(option)

    send_resp(conn, :no_content, "")
  end
end
