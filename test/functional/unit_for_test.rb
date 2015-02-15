require 'test_helper'

class UnitForTest < ActiveSupport::TestCase
  def setup
    @subject = Ingredient.new
  end

  test 'defines a getter that returns nil if the value is nil' do
    @subject.protein_unit = 'g'
    assert_respond_to @subject, :protein
    assert_nil @subject.protein
  end

  test 'defines a getter that returns nil if the unit is nil' do
    @subject.protein_value = 1
    assert_respond_to @subject, :protein
    assert_nil @subject.protein
  end

  test 'defines a getter that returns a measurement' do
    @subject.protein_value = 1
    @subject.protein_unit = 'g'
    assert_respond_to @subject, :protein
    assert_instance_of Unitwise::Measurement, @subject.protein
  end

  test 'defines a setter that sets the value and the unit attributes' do
    assert_respond_to @subject, :protein=
    @subject.protein = Unitwise(100, 'g')
    assert_equal 100, @subject.protein_value
    assert_equal 'g', @subject.protein_unit
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
    assert_equal 100, @subject.carbohydrate_value
    assert_equal 'g', @subject.carbohydrate_unit
  end

  test 'before save do nothing if the value is nil' do
    @subject.save!
    assert_nil @subject.carbohydrate
  end

  test '#units return a hash with all the units and their options' do
    units = [{ name: :protein, options: {} },
             { name: :carbohydrate, options: { convert_to: 'g' } }]
    assert_equal units, Ingredient.units
  end
end
