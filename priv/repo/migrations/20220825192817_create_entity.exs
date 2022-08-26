defmodule ArvoreApi.Repo.Migrations.CreateEntity do
  use Ecto.Migration

  def change do
    create table(:entity) do
      add :name, :string
      add :entity_type, :string
      add :inep, :integer
      add :parent_id, references(:entity)
      timestamps()
    end
  end
end
