class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def edit
	end

	def show
		@post = Post.find(params[:id])
	end

	def create
		@post = Post.new(params.require(:post).permit(:body).merge(user: current_user))

		if @post.save
			redirect_to posts_path, notice: "New post created!"
		else
			render :new
		end
	end

	def update
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		respond_to do |format|
			format.html { redirect_to root_path, alert: "Post deleted." }
			format.js { render nothing: true }
		end
	end
end
