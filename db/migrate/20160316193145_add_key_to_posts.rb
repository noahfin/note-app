class AddKeyToPosts < ActiveRecord::Migration
  def change
  	add_reference :posts, :user, index: true, foregign_key: true
  end
end
