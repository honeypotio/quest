defmodule QuestAdmin.OptionController do
  use QuestAdmin.Web, :controller

  alias QuestAdmin.Option

  def index(conn, _params) do
    options = Repo.all(Option)
    render(conn, "index.html", options: options)
  end

  def new(conn, %{"option" => option_params}) do
    changeset = Option.changeset(%Option{}, option_params)
    render(conn, "new.html", changeset: changeset, questions: questions)
  end
  def new(conn, _params) do
    changeset = Option.changeset(%Option{})
    render(conn, "new.html", changeset: changeset, questions: questions)
  end

  def create(conn, %{"option" => option_params}) do
    changeset = Option.changeset(%Option{}, option_params)

    case Repo.insert(changeset) do
      {:ok, _option} ->
        conn
        |> put_flash(:info, "Option created successfully.")
        |> redirect(to: option_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, questions: questions)
    end
  end

  def show(conn, %{"id" => id}) do
    option = Repo.get!(Option, id)
    render(conn, "show.html", option: option)
  end

  def edit(conn, %{"id" => id}) do
    option = Repo.get!(Option, id)
    changeset = Option.changeset(option)
    render(conn, "edit.html", option: option, changeset: changeset, questions: questions)
  end

  def update(conn, %{"id" => id, "option" => option_params}) do
    option = Repo.get!(Option, id)
    changeset = Option.changeset(option, option_params)

    case Repo.update(changeset) do
      {:ok, option} ->
        conn
        |> put_flash(:info, "Option updated successfully.")
        |> redirect(to: option_path(conn, :show, option))
      {:error, changeset} ->
        render(conn, "edit.html", option: option, questions: questions, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    option = Repo.get!(Option, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(option)

    conn
    |> put_flash(:info, "Option deleted successfully.")
    |> redirect(to: option_path(conn, :index))
  end

  defp questions do
    Repo.all(QuestAdmin.Question) |> Enum.map(&{&1.code, &1.id})
  end
end
