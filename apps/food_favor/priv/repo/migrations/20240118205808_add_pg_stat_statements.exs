defmodule FoodFavor.Repo.Migrations.AddPGStatStatements do
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION pg_stat_statements", "DROP EXTENSION pg_stat_statements")
  end
end
