require 'test_helper'

class ValidatorsTest < ActiveSupport::TestCase
  def teardown
    Ingredient.clear_validators!
  end

  test 'validate presence of unit' do
    Ingredient.validates_unit_presence(:carbohydrate, :protein)
    subject = Ingredient.new
    assert subject.invalid?
    assert_equal ['must be blank'], subject.errors[:carbohydrate]
    assert_equal ['must be blank'], subject.errors[:protein]

    subject.carbohydrate = Unitwise(1, 'g')
    subject.protein = Unitwise(1, 'g')
    assert subject.valid?
  end

  test 'validate presence of a non unit attribute raises' do
    Ingredient.validates_unit_presence(:protein_unit)
    subject = Ingredient.new

    assert_raise(ArgumentError) { subject.invalid? }
  end

  test 'validate presence of a non existant attribute raises' do
    Ingredient.validates_unit_presence(:invalid_attr)
    subject = Ingredient.new

    assert_raise(ArgumentError) { subject.valid? }
  end
end
