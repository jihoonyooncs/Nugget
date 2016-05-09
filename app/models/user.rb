class User < ActiveRecord::Base
	acts_as_voter
	has_many :subscriptions, foreign_key: :follower_id, dependent: :destroy
	has_many :leaders, through: :subscriptions

	has_many :reverse_subscriptions, foreign_key: :leader_id, class_name: 'Subscription', dependent: :destroy
	has_many :followers, through: :reverse_subscriptions

	has_many :posts, dependent: :destroy
	has_many :text_posts, dependent: :destroy
	has_many :image_posts, dependent: :destroy

	has_secure_password
	validates :email, presence: true, uniqueness: true
	validates :screenname, presence: true, uniqueness: true

	has_many :comments

	has_many :notifications
	has_many :friendships
	has_many :accepted_friendships, 
			-> {where status: 'accepted'},
			:class_name => "Friendship"
	has_many :requested_friendships, 
			-> {where status: 'requested'},
			:class_name => "Friendship"
	has_many :pending_friendships, 
			-> {where status: 'pending'},
			:class_name => "Friendship"
	has_many :friends, :through => :accepted_friendships
	has_many :requested_friends, :through => :requested_friendships, :source => :friend
	has_many :pending_friends, :through => :pending_friendships, :source => :friend

	def following?(leader)
		leaders.include? leader
	end
	
	def follow!(leader)
		if leader != self && !following?(leader)
			leaders << leader
		end
	end
	
	def timeline_user_ids
		leader_ids
	end
end