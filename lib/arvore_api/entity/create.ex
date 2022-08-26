defmodule ArvoreApi.Entity.Create do
  alias ArvoreApi.{Repo, Entity}

  def call(params) do
    params
    |> Entity.build()
    |> create_entity()
  end

  defp create_entity({:ok, struct}), do: Repo.insert(struct)
  defp create_entity({:error, _changeset} = error), do: error
end
