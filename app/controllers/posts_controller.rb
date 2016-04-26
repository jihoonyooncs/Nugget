class PostsController < ApplicationController
	#upvote_from user
	#downvote_from user
	def upvote
		@post = Post.includes(:user).find(params[:id])
		@post.upvote_from current_user
		redirect_to posts_path
	end

	def downvote
		@post = Post.includes(:user).find(params[:id])
		@post.downvote_from current_user
		redirect_to posts_path
	end

	def tagged
		if params[:tag].present? 
			@posts = Post.tagged_with(params[:tag])
		else 
			@posts = Post.postall
		end  
	end

	def show
		@post = Post.includes(comments: [:user]).find(params[:id])
	end

	def index
		if params[:tag]
			@posts = Post.includes(:user).tagged_with(params[:tag]).all.paginate(page: params[:page], per_page: 5).order("created_at DESC");
		else
			@posts = Post.includes(:user).all.paginate(page: params[:page], per_page: 5).order("created_at DESC")
		end
	end

	def subindex
		if(current_user && !@tester)
			user_ids = current_user.timeline_user_ids
			@posts = Post.includes(:user).where(user_id: user_ids).paginate(page: params[:page], per_page: 5).order("created_at DESC")	
		end
	end
end