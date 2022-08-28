defmodule ArvoreApi.Entities do
  @moduledoc """
    Utilizado para encaminhar as informações ao changeset e executar o Repo.
  """

  alias ArvoreApi.Repo
  alias ArvoreApi.Entity

  def get(id) do
    Repo.get(Entity, id)
  end

  def preload_children(entity) do
    Repo.preload(entity, :children)
  end

  def create_class(attrs) do
    case attrs do
      %{"parent_id" => nil} ->
        {:error, :invalid_parent}

      %{"parent_id" => parent_id} ->
        with %{entity_type: entity_type} <- get(parent_id),
             "school" <- entity_type do
          Entity.class_changeset(%Entity{}, attrs)
          |> Repo.insert()
        else
          _ -> {:error, :invalid_parent}
        end
    end
  end

  def create_school(attrs) do
    case attrs do
      %{"parent_id" => nil} ->
        Entity.school_changeset(%Entity{}, attrs)
        |> Repo.insert()

      %{"parent_id" => parent_id} ->
        with %{entity_type: entity_type} <- get(parent_id),
             :ok <- get_school_parent(entity_type) do
          Entity.school_changeset(%Entity{}, attrs)
          |> Repo.insert()
        else
          _ -> {:error, :invalid_parent}
        end
    end
  end

  def create_network(attrs) do
    case attrs do
      %{"parent_id" => nil} ->
        Entity.network_changeset(%Entity{}, attrs)
        |> Repo.insert()

      _ ->
        {:error, :invalid_parent}
    end
  end

  def update_class(id, attrs) do
    case Repo.get(Entity, id) do
      nil ->
        {:error, "Entity not found"}

      entity ->
        with %{"parent_id" => parent_id} <- attrs,
             %{entity_type: entity_type} <- get(parent_id),
             "school" <- entity_type do
          Entity.class_changeset(entity, attrs)
          |> Repo.update()
        else
          _ -> {:error, :invalid_parent}
        end
    end
  end

  def update_school(id, attrs) do
    case Repo.get(Entity, id) do
      nil ->
        {:error, "Entity not found"}

      entity ->
        with %{"parent_id" => parent_id} <- attrs,
             %{entity_type: entity_type} <- get(parent_id),
             :ok <- get_school_parent(entity_type) do
          Entity.school_changeset(entity, attrs)
          |> Repo.update()
        else
          _ -> {:error, :invalid_parent}
        end
    end
  end

  def update_network(id, attrs) do
    case Repo.get(Entity, id) do
      nil ->
        {:error, "Entity not found"}

      entity ->
        Entity.network_changeset(entity, attrs)
        |> Repo.update()
    end
  end

  defp get_school_parent(parent) do
    case parent do
      "network" -> :ok
      _ -> :error
    end
  end
end
