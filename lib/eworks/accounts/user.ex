defmodule Eworks.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :city, :string
    field :country, :string
    field :county, :string
    field :email, :string
    field :full_name, :string
    field :is_active, :boolean, default: false
    field :is_client, :boolean, default: false
    field :is_suspended, :boolean, default: false
    field :is_verified, :string
    field :phone, :string
    field :rating, :integer
    field :street, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:phone, :email, :city, :county, :street, :country, :rating, :full_name, :is_client, :is_active, :is_verified, :is_suspended])
    |> validate_required([:phone, :email, :city, :county, :street, :country, :rating, :full_name, :is_client, :is_active, :is_verified, :is_suspended])
  end
end
