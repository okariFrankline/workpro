defmodule Eworks.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :phone, :string, null: false, unique: true
      add :email, :string, null: false, unique: true
      add :city, :string, null: false
      add :county, :string, null: false
      add :description, :text, null: true
      add :street, :string, null: false
      add :country, :string, null: false
      add :rating, :integer, default: 1, null: false
      add :full_name, :string, null: false
      add :is_service_provider, :boolean, default: false, null: false
      add :is_active, :boolean, default: false, null: false
      add :is_verified, :boolean, default: false, null: false
      add :is_suspended, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:users, [:phone])
    create unique_index(:users, [:email])
    create index(:users, [:full_name])
  end
end
