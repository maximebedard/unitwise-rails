# [unitwise-rails](http://github.com/maximebedard/unitwise-rails)

[![Code Climate](https://codeclimate.com/github/maximebedard/unitwise-rails/badges/gpa.svg)](https://codeclimate.com/github/maximebedard/unitwise-rails) [![Circle CI](https://circleci.com/gh/maximebedard/unitwise-rails.svg?style=svg)](https://circleci.com/gh/maximebedard/unitwise-rails)

unitwise-rails is a gem that provides rails extension to the the refined
[unitwise](https://github.com/joshwlewis/unitwise) gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'unitwise-rails', github: 'maximebedard/unitwise-rails'
```

## Migrations

```ruby
# Add the fields :protein_value and :protein_unit when the
# migration is executed.
class AddUnitToIngredients < ActiveRecord::Migration
  def self.up
    add_unit :ingredients, :protein
  end

  def self.down
    remove_unit :ingredients, :protein
  end
end

class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.unit :protein
      t.timestamps
    end
  end
end
```

## Models

```ruby
# Add a method #protein to the model that will always be converted to grams
class Ingredient < ActiveRecord::Base
  # Add unit with automatic conversion to grams before save
  unit_for :protein, convert_to: :gram

  # Add unit with compatibility validation
  unit_for :carbohydrate
  validates_unit_compatibility_of :carbohydrate, with: :gram
  validates_unit_presence_of :carbohydrate

  # or
  validates_unit :carbohydrate, presence: true, compatibility: :gram
end
```

## TODOs

- [x] Add `unit_for` extension to ActiveRecord::Base
- [x] Add `unit` generation to migrations
- [ ] Add `validates_unit` validator
- [x] Add `validates_unit_compatibility_of` validator
- [x] Add `validates_unit_presence_of` validator
- [ ] Add `Unitwise::Rails::Migration` tests