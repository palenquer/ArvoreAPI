defmodule ArvoreApiWeb.ControllerTest do
  use ArvoreApiWeb.ConnCase

  @network_attrs %{
    "name" => "Network",
    "entity_type" => "network",
    "inep" => nil,
    "parent_id" => nil
  }

  @error_network_attrs %{
    "name" => "Network",
    "entity_type" => "network",
    "inep" => nil,
    "parent_id" => 1
  }

  @school_attrs %{
    "name" => "Escola",
    "entity_type" => "school",
    "inep" => 123,
    "parent_id" => nil
  }

  @error_school_attrs %{
    "name" => "Escola",
    "entity_type" => "school",
    "inep" => nil,
    "parent_id" => nil
  }

  @error_class_attrs %{
    "name" => "Class",
    "entity_type" => "class",
    "inep" => nil,
    "parent_id" => nil
  }

  describe "create" do
    test "creates school when data is valid", %{conn: conn} do
      conn = post(conn, Routes.arvore_path(conn, :create), @school_attrs)
      assert %{"id" => id} = json_response(conn, 201)

      conn = get(conn, Routes.arvore_path(conn, :show, id))
      assert @school_attrs = json_response(conn, 200)
    end

    test "creates class when data is valid", %{conn: conn} do
      conn = post(conn, Routes.arvore_path(conn, :create), @school_attrs)
      assert %{"id" => school_id} = json_response(conn, 201)

      conn =
        post(conn, Routes.arvore_path(conn, :create), %{
          "name" => "Classe",
          "entity_type" => "class",
          "inep" => nil,
          "parent_id" => school_id
        })

      assert %{"id" => id} = json_response(conn, 201)

      conn = get(conn, Routes.arvore_path(conn, :show, id))

      assert %{
               "name" => "Classe",
               "entity_type" => "class",
               "inep" => nil,
               "parent_id" => ^school_id
             } = json_response(conn, 200)
    end

    test "creates network when data is valid", %{conn: conn} do
      conn = post(conn, Routes.arvore_path(conn, :create), @network_attrs)
      assert %{"id" => id} = json_response(conn, 201)

      conn = get(conn, Routes.arvore_path(conn, :show, id))
      assert @network_attrs = json_response(conn, 200)
    end

    test "returns error when inep school is invalid", %{conn: conn} do
      conn = post(conn, Routes.arvore_path(conn, :create), @error_school_attrs)

      assert %{
               "message" => %{
                 "inep" => ["can't be blank"]
               }
             } = json_response(conn, 400)
    end

    test "returns error when parent class is invalid", %{conn: conn} do
      conn = post(conn, Routes.arvore_path(conn, :create), @error_class_attrs)
      assert %{"message" => "invalid_parent"} = json_response(conn, 400)
    end

    test "returns error when parent network is invalid", %{conn: conn} do
      conn = post(conn, Routes.arvore_path(conn, :create), @error_network_attrs)
      assert %{"message" => "invalid_parent"} = json_response(conn, 400)
    end
  end
end
