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

  def class_changeset(entity, params) do
    entity
    |> cast(params, [:name, :entity_type, :parent_id])
    |> validate_required([:name, :entity_type, :parent_id])
    |> validate_inclusion(:entity_type, ["class"])
  end

  def school_changeset(entity, params) do
    entity
    |> cast(params, [:name, :entity_type, :inep, :parent_id])
    |> validate_required([:name, :entity_type, :inep])
    |> validate_inclusion(:entity_type, ["school"])
  end

  def network_changeset(entity, params) do
    entity
    |> cast(params, [:name, :entity_type])
    |> validate_required([:name, :entity_type])
    |> validate_inclusion(:entity_type, ["network"])
  end
end
