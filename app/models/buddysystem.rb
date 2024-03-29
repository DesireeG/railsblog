class Buddysystem < ActiveRecord::Base
	belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates_uniqueness_of :follower_id, scope: :followed_id
  validates_uniqueness_of :followed_id, scope: :follower_id
end
