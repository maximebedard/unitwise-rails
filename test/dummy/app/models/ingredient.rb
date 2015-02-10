class Ingredient < ActiveRecord::Base
  unit_for :protein
  unit_for :carbohydrate, convert_to: 'g'

  def my_custom_unit
    'gram'
  end
end
