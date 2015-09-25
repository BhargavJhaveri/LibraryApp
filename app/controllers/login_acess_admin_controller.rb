class LoginAcessAdminController < ApplicationController
	before_action :logged_in_admin ,:except => [:login,:attempt_login,:logout]
  def login
  end

  def attempt_login
  	if params[:email].present? && params[:password].present?
  		found_user=LibraryAdmin.where(:email =>params[:email]).first
  		if found_user
  			authorized_user=found_user.authenticate(params[:password])
  		end
  	end
  	if authorized_user

  		session[:admin_id]=authorized_user.id
  		session[:email]=authorized_user.email

  		flash[:notice] = "you are now logged in"
      i=authorized_user.id.to_s
  		redirect_to(:controller => 'admin',:action => 'index')

  	else
  		flash[:notice]="Invalid username or password"
  		redirect_to(:action => 'login')
  	end
  end

  def logout
  	session[:admin_id]=nil
    session[:email]=nil

  	flash[:notice]="logout"
  	redirect_to(:action => 'login')
  end
end
