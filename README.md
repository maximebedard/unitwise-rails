# [unitwise-rails](http://github.com/maximebedard/unitwise-rails)

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
  unit_for :protein, convert_to: 'g'
end
```

## TODOs

- [x] Add `unit_for` extension to ActiveRecord::Base
- [x] Add `unit` generation to migrations
- [ ] Add `validate_compatibility_of` Validator
- [ ] Add specs
  - [ ] unit_for
  - [ ] schema
  - [ ] validator
