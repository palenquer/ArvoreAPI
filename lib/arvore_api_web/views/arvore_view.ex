defmodule ArvoreApiWeb.ArvoreView do
  use ArvoreApiWeb, :view

  def render("show.json", %{entity: entity}) do
    %{
      id: entity.id,
      entity_type: entity.entity_type,
      inep: entity.inep,
      name: entity.name,
      parent_id: entity.parent_id,
      subtree_ids: Enum.map(entity.children, fn item -> item.id end)
    }
  end
end
