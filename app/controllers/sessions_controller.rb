class SessionsController < ApplicationController

  def create
    if User.authenticate(params[:username], params[:password])
      @user = User.find_by_username(params[:username])
      session[:id] = @user.id
      redirect_to root_path
    else
      @error = "Please enter correct username/password"
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end