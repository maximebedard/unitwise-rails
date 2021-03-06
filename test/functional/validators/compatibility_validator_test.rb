require 'test_helper'

class CompatibilityValidatorTest < ActiveSupport::TestCase
  def teardown
    Ingredient.clear_validators!
  end

  test 'validate unit compatibility' do
    Ingredient.validates_unit_compatibility_of(:protein, with: :gram)
    subject = Ingredient.new

    subject.protein = Unitwise(1, 'watt')
    assert subject.invalid?
    assert_equal ["doesn't match gram"], subject.errors[:protein]

    subject.protein = Unitwise(1, 'g')
    assert subject.valid?
  end

  test 'validate unit compatibility with an invalid unit raises' do
    Ingredient.validates_unit_compatibility_of(:protein, with: :invalid_unit)
    subject = Ingredient.new

    subject.protein = Unitwise(1, 'g')
    assert_raise(Unitwise::ExpressionError) { subject.valid? }
  end

  test 'validate compatibility with a lambda' do
    Ingredient.validates(:protein, compatibility: { with: :my_custom_unit })
    subject = Ingredient.new

    subject.protein = Unitwise(1, 'mg')
    assert subject.valid?

    subject.protein = Unitwise(1, 'watt')
    assert subject.invalid?
  end
end
