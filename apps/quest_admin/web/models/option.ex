defmodule QuestAdmin.Option do
  use QuestAdmin.Web, :model

  schema "options" do
    field :code, :string
    field :body, :string
    field :created_by, :integer
    field :updated_by, :integer
    belongs_to :question, QuestAdmin.Question

    timestamps()
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
