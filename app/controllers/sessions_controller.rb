class SessionsController < ApplicationController

  def new
  end

  def create
  	@user = User.find_by_email(params[:email])
  	if @user and @user.password == params[:password]
  		session[:user_id] = @user.id
  		redirect_to posts_path(@user.username), notice: "Log In Successful!"
  	else
  		flash[:alert] = "Uh Oh. Something is wrong with what you typed in."
  		render :new
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_path, notice: "See You Later!"
  end



end
