defmodule Eworks.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :phone, :string
      add :email, :string
      add :city, :string
      add :county, :string
      add :street, :string
      add :country, :string
      add :rating, :integer
      add :full_name, :string
      add :is_client, :boolean, default: false, null: false
      add :is_active, :boolean, default: false, null: false
      add :is_verified, :string
      add :is_suspended, :boolean, default: false, null: false

      timestamps()
    end

  end
end
