class DeleteAttributeCreatedAt < ActiveRecord::Migration
  def change
  	remove_column :posts, :time_created_at, :datetime
  end
end
