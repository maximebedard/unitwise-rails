class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.unit :protein
      t.unit :carbohydrate
      t.unit :iron
      t.timestamps
    end
  end
end
