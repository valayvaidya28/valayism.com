class DropCategorisationTable < ActiveRecord::Migration
  def up
  	drop_table :categorisations
  end
end
