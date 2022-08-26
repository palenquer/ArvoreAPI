defmodule ArvoreApiWeb.FallbackController do
  use ArvoreApiWeb, :controller

  def call(conn, {:error, %{status: status} = result}) do
    conn
    |> put_status(status)
    |> put_view(ArvoreApiWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
