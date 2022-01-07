class SessionController < ApplicationController
  
  def create
    user = User.find_by_email(params[:email])
   
    # if the user exists AND the password entered is correct.
    if user && User.authenticate_with_credentials(params[:email], params[:password])
      # save the user id inside the browser cookie. this is how we keep the user logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/products#index'
    else
    # if user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
