defmodule ArvoreApi.Entity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entity" do
    field :name, :string
    field :entity_type, :string
    field :inep, :integer
    belongs_to :parent, __MODULE__
    has_many :children, __MODULE__, foreign_key: :parent_id
    timestamps()
  end

  @required_params [:name, :entity_type, :inep]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params), do: create_changeset(%__MODULE__{}, params)

  defp create_changeset(module, params) do
    module
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
