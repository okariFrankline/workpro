defmodule EworksWeb.UserControllerTest do
  use EworksWeb.ConnCase

  alias Eworks.Accounts
  alias Eworks.Accounts.User

  @create_attrs %{
    city: "some city",
    country: "some country",
    county: "some county",
    email: "some email",
    full_name: "some full_name",
    is_active: true,
    is_client: true,
    is_suspended: true,
    is_verified: "some is_verified",
    phone: "some phone",
    rating: 42,
    street: "some street"
  }
  @update_attrs %{
    city: "some updated city",
    country: "some updated country",
    county: "some updated county",
    email: "some updated email",
    full_name: "some updated full_name",
    is_active: false,
    is_client: false,
    is_suspended: false,
    is_verified: "some updated is_verified",
    phone: "some updated phone",
    rating: 43,
    street: "some updated street"
  }
  @invalid_attrs %{city: nil, country: nil, county: nil, email: nil, full_name: nil, is_active: nil, is_client: nil, is_suspended: nil, is_verified: nil, phone: nil, rating: nil, street: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "city" => "some city",
               "country" => "some country",
               "county" => "some county",
               "email" => "some email",
               "full_name" => "some full_name",
               "is_active" => true,
               "is_client" => true,
               "is_suspended" => true,
               "is_verified" => "some is_verified",
               "phone" => "some phone",
               "rating" => 42,
               "street" => "some street"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "city" => "some updated city",
               "country" => "some updated country",
               "county" => "some updated county",
               "email" => "some updated email",
               "full_name" => "some updated full_name",
               "is_active" => false,
               "is_client" => false,
               "is_suspended" => false,
               "is_verified" => "some updated is_verified",
               "phone" => "some updated phone",
               "rating" => 43,
               "street" => "some updated street"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end
