class CreateBuddysystems < ActiveRecord::Migration
  def change
    create_table :buddysystems do |t|

     	t.integer :follower_id
        t.integer :followed_id

     	t.timestamps null: false
    end
  end
end
