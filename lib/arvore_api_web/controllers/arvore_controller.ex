defmodule ArvoreApiWeb.ArvoreController do
  use ArvoreApiWeb, :controller

  alias ArvoreApi.Entities

  action_fallback ArvoreApiWeb.FallbackController

  def create(conn, params) do
    case params do
      %{"entity_type" => "school"} ->
        Entities.create_school(params)
        |> handle_response(conn, "show.json", :created)

      %{"entity_type" => "class"} ->
        Entities.create_class(params)
        |> handle_response(conn, "show.json", :created)

      %{"entity_type" => "network"} ->
        Entities.create_network(params)
        |> handle_response(conn, "show.json", :created)
    end
  end

  def show(conn, %{"id" => id}) do
    case Entities.get(id) do
      nil ->
        conn
        |> put_status(404)
        |> text("Entity not found!")

      entity ->
        {:ok, entity}
        |> handle_response(conn, "show.json", :ok)
    end
  end

  def update(conn, %{"id" => id} = params) do
    case params do
      %{"entity_type" => "school"} ->
        Entities.update_school(id, params)
        |> handle_response(conn, "show.json", :ok)

      %{"entity_type" => "class"} ->
        Entities.update_class(id, params)
        |> handle_response(conn, "show.json", :ok)

      %{"entity_type" => "network"} ->
        Entities.update_network(id, params)
        |> handle_response(conn, "show.json", :ok)
    end
  end

  defp handle_response({:ok, entity}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, entity: Entities.preload_children(entity))
  end

  defp handle_response({:error, _changeset} = error, _conn, _view, _status), do: error
end
