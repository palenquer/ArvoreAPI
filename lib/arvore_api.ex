defmodule ArvoreApi do
  alias ArvoreApi.Entity
  defdelegate create_entity(params), to: Entity.Create, as: :call
  defdelegate update_entity(params), to: Entity.Update, as: :call
end
