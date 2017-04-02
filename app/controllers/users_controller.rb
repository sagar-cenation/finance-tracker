class UsersController < ApplicationController
	def my_portfolio
		@user_stocks = current_user.stocks.paginate(page: params[:page], per_page: 5)
		@user = current_user		
	    
	end

	def my_friends
		@friendships=current_user.friends
	end

	def search
		@users = user.search(params[:search_param])

		if @users
			@users = current_user.except_current_user(@users)
			render partial: "friends/lookup"
		else
			render status: :not_found, nothing: true
		end
	end

	def add_friend
		@friend = User.find(params[:friend])
		current_user.friendships.build(friend_id: @friend.id) #since we are building associations

		if current_user.save
			redirect_to my_friends_path, notice: "Friend was successfully added"
		else
			redirect_to my_friends_path, flash[:error]= "There was an error with adding user as friend"
		end
	end

	def not_friends_with?(friend_id)
		friendships.where(friend_id: friend.id).count < 1
	end

	def except_current_user(users)
		users.reject{ |user| user.id == self.id }
	end

	def self.search(param)
		return User.none if param.blank?
		param.strip!
		param.downcase!
		(first_name_matches(param) + last_name_matches(param) + email_matches(param)).unique
	end
end