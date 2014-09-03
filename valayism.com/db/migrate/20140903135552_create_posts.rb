class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.string :title, 					null: false, default: ""
    	t.string :content,				null: false, default: ""
    	t.string :type,						null: false
    	t.datetime :time_created_at
      t.timestamps
    end
  end
end
