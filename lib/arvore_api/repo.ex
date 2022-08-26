defmodule ArvoreApi.Repo do
  use Ecto.Repo,
    otp_app: :arvore_api,
    adapter: Ecto.Adapters.MyXQL
end
