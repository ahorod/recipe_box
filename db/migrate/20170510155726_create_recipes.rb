class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table(:recipes) do |t|
      t.column(:name, :string)
      t.column(:rating, :integer)

      t.timestamps()
    end
    create_table(:tags) do |t|
      t.column(:name, :string)

      t.timestamps()
    end

    create_table(:ingredients) do |t|
      t.column(:name, :string)

      t.timestamps()
    end
  end
end
