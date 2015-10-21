class SessionsController < ApplicationController
  def new
  end
  def create
  	user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
          # Log the user in and redirect to their profile page.
          remember user
          redirect_to user
        else
          flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
          render 'new'
        end

  end

  def destroy
  end
  # Remembers a user in a persistent session.
      def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
      end
      def destroy
        log_out if logged_in?
        redirect_to root_url
      end 
end
