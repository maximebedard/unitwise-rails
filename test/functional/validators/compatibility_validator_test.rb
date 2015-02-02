require 'test_helper'

class ValidatorsTest < ActiveSupport::TestCase
  def teardown
    Ingredient.clear_validators!
  end

  test 'validate unit compatibility' do
    Ingredient.validates_unit_compatibility_of(:protein, with: :gram)
    subject = Ingredient.new

    subject.protein = Unitwise(1, 'watt')
    assert subject.invalid?
    assert ['asdasd'], subject.errors[:protein]

    subject.protein = Unitwise(1, 'g')
    assert subject.valid?
  end

  test 'validate unit compatibility with an invalid unit raises' do
    Ingredient.validates_unit_compatibility_of(:protein, with: :invalid_unit)
    subject = Ingredient.new

    subject.protein = Unitwise(1, 'g')
    assert_raise(Unitwise::ExpressionError) { subject.valid? }
  end

  test 'validate unit compatibility of a non unit attribute raises' do
    Ingredient.validates_unit_compatibility_of(:protein_unit, with: :gram)
    subject = Ingredient.new

    subject.protein = Unitwise(1, 'g')
    assert_raise(ArgumentError) { subject.valid? }
  end

  test 'validate compatibility of a non existant attribute raises' do
    Ingredient.validates_unit_compatibility_of(:invalid_attr, with: :invalid_unit)
    subject = Ingredient.new

    assert_raise(ArgumentError) { subject.valid? }
  end
end
