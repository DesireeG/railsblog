class UsersController < ApplicationController
	 before_action :authenticate_user!, only: [:edit, :update, :destroy, :close, :password, :follow, :unfollow]
		# DEF NEW USER
def new
	@user = User.new

end

		# ---------CREATE----------
def create
	@user = User.new(user_params)
  		if  @user.save
  			session[:user_id] = @user.id
  			redirect_to allposts_path(@user.username), notice: "Account Successfully Created"
  		else
  			render :new
  		end
end



  def edit
  	@user = current_user
  end

  def show
  	@user = User.find_by_username(params[:username])
  end


   def close
  end

  def password
  	@user = current_user
  end


	def update
	  	@user = current_user
	  	old_password = params[:user][:current_password]
	  	if old_password
	  		if old_password == current_user.password
	  			if @user.update(user_params.except(:current_password))
	  				redirect_to username_path(@user.username), notice: "Password updated."
	  			else
	  				render :password
	  			end
	  		else
	  			flash[:alert] = "Wrong password"
	  			render :password
	  		end
	  	elsif @user.update(user_params)
	  		redirect_to username_path(@user.username), notice: "Profile updated."
	  	else
	  		render :edit
	  	end
	  end

	  def destroy
	  	@user = current_user
	  	if @user.password == params[:user][:password]
	  		@user.destroy
	  		session[:user_id] = nil
	  		redirect_to root_path, notice: "Your account has been deleted."
	  	else
	  		flash[:alert] = "Wrong password. Having second thoughts?"
	  		render :close
	  	end
	  end








		# -------FOLLOW-----------

  def follow
    @buddysystem = Buddysystem.new(follower_id: current_user.id, followed_id: params[:id])
    @user = User.find(params[:id])
    
    if @buddysystem.save
      flash[:notice] = "You've successfully followed #{@user.username}."
    else
      flash[:alert] = "There was an error following that user."
    end
    redirect_to username_path(@user.username)
  end

		# -------UNFOLLOW-----------

  def unfollow
    @buddysystem = Buddysystem.find_by(follower_id: current_user.id, followed_id: params[:id])
    @user = User.find(params[:id])
    if @buddysystem and @buddysystem.destroy
      flash[:notice] = "You've successfully unfollowed #{@user.username}."
    else
      flash[:alert] = "There was an error unfollowing that user."
    end
    redirect_to username_path(@user.username)
  end


  private

  def user_params
  	params.require(:user).permit(:username, :email, :lname, :fname, :password, :password_confirmation, :current_password, :image)
  end

end