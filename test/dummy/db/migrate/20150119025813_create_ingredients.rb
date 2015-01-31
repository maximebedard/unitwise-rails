class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :protein_value
      t.string :protein_unit
      t.string :carbohydrate_value
      t.string :carbohydrate_unit

      t.timestamps
    end
  end
end
