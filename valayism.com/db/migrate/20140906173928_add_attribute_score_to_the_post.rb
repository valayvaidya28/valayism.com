class AddAttributeScoreToThePost < ActiveRecord::Migration
  def change
    add_column :posts, :score, :integer
  end
end
