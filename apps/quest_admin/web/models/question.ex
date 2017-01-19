defmodule QuestAdmin.Question do
  use QuestAdmin.Web, :model

  schema "questions" do
    field :code, :string
    field :body, :string
    field :created_by, :integer
    field :updated_by, :integer

    timestamps(inserted_at: :created_at)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:code, :body, :created_by, :updated_by])
    |> validate_required([:code, :body, :created_by, :updated_by])
  end
end
