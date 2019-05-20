defmodule EvilCorp.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add(:data, :string)

      timestamps()
    end
  end
end
