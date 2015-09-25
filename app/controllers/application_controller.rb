class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private

  def logged_in
  	unless session[:member_id]
  		flash[:notice]="please log in"
  		redirect_to(:controller=> 'login_acess',:action => 'login')
  		return false
  	else
  		return true
  	end

  	
  end

   def logged_in_admin
    unless session[:admin_id]
      flash[:notice]="please log in"
      redirect_to(:controller=>'login_acess_admin',:action => 'login')
      return false
    else
      return true
    end

    
  end
end
