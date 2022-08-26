defmodule ArvoreApi do
  alias ArvoreApi.Entity
  defdelegate create_entity(params), to: Entity.Create, as: :call
end
