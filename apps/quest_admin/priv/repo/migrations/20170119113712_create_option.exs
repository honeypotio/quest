defmodule QuestAdmin.Repo.Migrations.CreateOption do
  use Ecto.Migration

  def change do
    create table(:options) do
      add :code, :string
      add :body, :string
      add :created_by, :integer
      add :updated_by, :integer
      add :question_id, references(:questions, on_delete: :nothing)

      timestamps()
    end
    create index(:options, [:question_id])

  end
end
