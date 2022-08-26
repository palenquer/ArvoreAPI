defmodule ArvoreApiWeb.FallbackController do
  use ArvoreApiWeb, :controller

  def call(conn, {:error, error}) do
    conn
    |> put_status(400)
    |> put_view(ArvoreApiWeb.ErrorView)
    |> render("400.json", result: error)
  end
end
