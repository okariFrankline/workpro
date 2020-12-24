defmodule Eworks.AccountsTest do
  use Eworks.DataCase

  alias Eworks.Accounts

  describe "users" do
    alias Eworks.Accounts.User

    @valid_attrs %{city: "some city", country: "some country", county: "some county", email: "some email", full_name: "some full_name", is_active: true, is_client: true, is_suspended: true, is_verified: "some is_verified", phone: "some phone", rating: 42, street: "some street"}
    @update_attrs %{city: "some updated city", country: "some updated country", county: "some updated county", email: "some updated email", full_name: "some updated full_name", is_active: false, is_client: false, is_suspended: false, is_verified: "some updated is_verified", phone: "some updated phone", rating: 43, street: "some updated street"}
    @invalid_attrs %{city: nil, country: nil, county: nil, email: nil, full_name: nil, is_active: nil, is_client: nil, is_suspended: nil, is_verified: nil, phone: nil, rating: nil, street: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.city == "some city"
      assert user.country == "some country"
      assert user.county == "some county"
      assert user.email == "some email"
      assert user.full_name == "some full_name"
      assert user.is_active == true
      assert user.is_client == true
      assert user.is_suspended == true
      assert user.is_verified == "some is_verified"
      assert user.phone == "some phone"
      assert user.rating == 42
      assert user.street == "some street"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.city == "some updated city"
      assert user.country == "some updated country"
      assert user.county == "some updated county"
      assert user.email == "some updated email"
      assert user.full_name == "some updated full_name"
      assert user.is_active == false
      assert user.is_client == false
      assert user.is_suspended == false
      assert user.is_verified == "some updated is_verified"
      assert user.phone == "some updated phone"
      assert user.rating == 43
      assert user.street == "some updated street"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
