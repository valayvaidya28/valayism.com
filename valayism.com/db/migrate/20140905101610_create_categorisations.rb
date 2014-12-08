class CreateCategorisations < ActiveRecord::Migration
  def change
    create_table :categorisations do |t|
      t.belongs_to :post_id
      t.belongs_to :category_id
      t.timestamps
    end
  end
end
