class RemovePhotoColumnFromPost < ActiveRecord::Migration
  def change
  	remove_attachment :posts, :photo
  end
end