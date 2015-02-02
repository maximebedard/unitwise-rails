require 'unitwise'

require 'unitwise/rails/version'
require 'unitwise/rails/unit_for'
require 'unitwise/rails/migration'
require 'unitwise/rails/validators'

if defined?(ActiveRecord)
  ActiveRecord::Base.send :include, Unitwise::Rails::UnitFor
  ActiveRecord::Base.send :include, Unitwise::Rails::Migration
  ActiveRecord::Base.send :include, Unitwise::Rails::Validators
end
