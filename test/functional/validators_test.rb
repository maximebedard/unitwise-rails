require 'test_helper'

class ValidatorsTest < ActiveSupport::TestCase
  def teardown
    Ingredient.clear_validators!
  end

  test 'validate presence of unit' do
    Ingredient.validates_presence_of(:carbohydrate, :protein)
    subject = Ingredient.new
    assert subject.invalid?
    assert_equal ["can't be blank"], subject.errors[:carbohydrate]
    assert_equal ["can't be blank"], subject.errors[:protein]

    subject.carbohydrate = Unitwise(1, 'g')
    subject.protein = Unitwise(1, 'g')
    assert subject.valid?
  end
end
