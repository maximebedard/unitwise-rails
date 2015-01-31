require 'test_helper'

class UnitForTest < ActiveSupport::TestCase
  def setup
    @subject = Ingredient.new
  end

  test 'defines a getter that returns a mesurement' do
    assert_respond_to @subject, :protein
    assert_instance_of Unitwise::Mesurement, @subject.protein
  end

  test 'defines a setter that sets the value and the unit attributes' do
    assert_respond_to @subject, :protein=
    @subject.protein = Unitwise(100, 'g')
    assert_equals 100, @subject.protein_value
    assert_equals 'g', @subject.protein_unit
  end

  test 'defines a query that returns true if the mesurement is present' do
    assert_respond_to @subject, :protein?
    assert_not @subject.protein?
    @subject.protein = Unitwise(100, 'g')
    assert @subject.protein?
  end

  test 'defines a before_save callback if the option convert_to is present' do
    @subject.carbohydrate = Unitwise(0.1, 'kg')
    @subject.save!
    assert_equals 100, @subject.carbohydrate
    assert_equals 'g', @subject.carbohydrate
  end

  test 'convert the mesurement before saving the record if the convert_to option is present' do
  end
end
