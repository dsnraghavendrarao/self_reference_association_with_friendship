class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         has_many :friendships
         has_many :friends, -> { where(friendships: { status: "accepted"}) }, :through => :friendships
         # has_many :requested_friends, :through => :friendships, :source => :friend, :conditions => "status = 'requested'", :order => :created_at
		 # has_many :pending_friends, :through => :friendships, :source => :friend, :conditions => "status = 'pending'", :order => :created_at

		 # has_many :requested_friends,->{where(friendships:{status: "accepted"})},:through => :friendships
		 # has_many :pending_friends,:source => :friend, :through => :friendships

		 has_many :got_request_friendships, -> { where(friendships: { status: "pending" }) }, class_name: 'Friendship', foreign_key: :friend_id
		 # has_many :requested_friendships, through: :got_request_friendships, source: :friend
     has_many :requested_friendships, -> { where(friendships: { status: "pending" }) }, class_name: 'Friendship', foreign_key: :user_id
end



# has_many :user_friendships
# has_many :friends, -> { where(user_friendships: { state: "accepted"}) }, through: :user_friendships
# has_many :pending_user_friendships, -> { where { state: "pending" } }, class_name: 'UserFriendship', foreign_key: :user_id                                  
# has_many :pending_friends, through: :pending_user_friendships, source: :friend