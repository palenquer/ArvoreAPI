defmodule ArvoreApiWeb.ArvoreController do
  use ArvoreApiWeb, :controller

  alias ArvoreApi.Entities

  action_fallback ArvoreApiWeb.FallbackController

  def create(conn, params) do
    params
    |> ArvoreApi.create_entity()
    |> handle_response(conn, "create.json", :created)
  end

  def show(conn, %{"id" => id}) do
    case Entities.get(id) do
      nil ->
        conn
        |> put_status(404)
        |> text("Entity not found!")

      entity ->
        conn
        |> put_status(200)
        |> render("show.json", entity: Entities.preload_children(entity))
    end
  end

  defp handle_response({:ok, entity}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, entity: entity)
  end

  defp handle_response({:error, _changeset} = error, _conn, _view, _status), do: error
end
