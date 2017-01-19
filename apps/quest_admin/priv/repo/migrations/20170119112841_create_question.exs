defmodule QuestAdmin.Repo.Migrations.CreateQuestion do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :code, :string
      add :body, :string
      add :created_by, :integer
      add :updated_by, :integer

      timestamps(inserted_at: :created_at)
    end

  end
end
