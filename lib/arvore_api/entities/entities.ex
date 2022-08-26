defmodule ArvoreApi.Entities do
  alias ArvoreApi.Repo
  alias ArvoreApi.Entity

  def get(id) do
    Repo.get(Entity, id)
  end

  def preload_children(entity) do
    Repo.preload(entity, :children)
  end
end
