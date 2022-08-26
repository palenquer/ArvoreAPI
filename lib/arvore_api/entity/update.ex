defmodule ArvoreApi.Entity.Update do
  alias ArvoreApi.{Entity, Repo}

  def call(%{"id" => id} = params) do
    case fetch_entity(id) do
      nil -> {:error, "Entity not found!"}
      entity -> update_entity(entity, params)
    end
  end

  defp fetch_entity(id), do: Repo.get(Entity, id)

  defp update_entity(entity, params) do
    entity
    |> Entity.changeset(params)
    |> Repo.update()
  end
end
