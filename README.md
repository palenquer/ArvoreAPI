# ArvoreApi

## Objetivo:

Construir uma API usando Phoenix (elixir) e banco de dados MySQL com estrutura de Redes, Escolas, Turmas.

## Rotas

### Deploy: https://arvore.fly.dev

### Rotas disponíveis:

* **GET** /api/v2/partners/entities/:id

* **POST** /api/v2/partners/entities

* **PUT** /api/v2/partners/entities/:id

### Exemplo de body JSON para os métodos **POST** e **PUT**:
```
{

  "name": "name",
  
  "entity_type": "class", "school" ou "network",
  
  "inep": null ou um número inteiro(caso o entity_type seja "school"),
  
  "parent_id": null ou um número inteiro(caso o entity_type seja "class" ou "school")
  
}
```

### Observações: 
* "class" deve estar relacionado a uma "school". Por tanto, deve conter um **parent_id**.
* "school" pode ou não estar relacionado a uma "network". Por tanto, pode ou não conter um **parent_id**.
* "network" não deve estar relacionado a ninguém. Por tanto, seu **parent_id** deve ser null.

## Testes

A pasta onde contém o código dos testes unitários se encontram em **test/arvore_api_web/controllers/controllers_test.exs**.

* Execute os testes com
`
mix test
`

# To start your Phoenix server:

  * Setup the project with `mix setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
