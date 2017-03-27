class UsersController < ApplicationController
  def index
    check_if_logged_in
  end
  def survey
    check_if_logged_in
    user = UserInfo.find_by(user_id: session[:user].id)
    if user
      flash[:errors] = ["Already Completed Survey"]
      redirect_to '/'
    else
      # render get to /survey
    end
  end

  def new
    
  end
  def create
    if params[:password] == params[:password_confirm]
      user = User.create(first_name: params[:first_name], last_name: params[:last_name], password: params[:password], sex: params[:sex], orientation: params[:orientation])
      if user.errors.full_messages[0]
        flash[:errors] = user.errors.full_messages
        session[:user]
         # add what we want to user object in session
        redirect_to '/users/new'
      else
        redirect_to '/survey'
      end
    else
      flash[:errors] = ["Passwords Do Not Match"]
      redirect_to '/users/new'
    end
  end
  def login
    user = User.find_by(email:params[:email])
    if user
      if user.authenticate(params[:password])
        session[:user]
        # add what we want to user object in session
        redirect_to '/'
      else
        flash[:errors] = ["Incorrect Password"]
        redirect_to '/users/new'
      end

    else
      flash[:errors] = ["Email Spelled Incorrect or Not Registered"]
      redirect_to '/users/new'
    end
  end
  def logout
    reset_session
    redirect_to '/users/new'
  end
  def show
    check_if_logged_in
    @user = User.find(params[:id])
  end
end