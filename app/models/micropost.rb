class Micropost < ActiveRecord::Base
	validates :user_id,presence: true
	default_scope ->{order('created_at DESC')}
	validates :content, presence: true,length: {maximum: 140}
	validates :user_id,presence: true
	belongs_to :user

	# Returns microposts from the users being followed by the given user.
	def self.from_users_followed_by(user)
		followed_user_ids="select followed_id from relationships where follower_id = :user_id"
		where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
			user_id: user.id)
	end

end