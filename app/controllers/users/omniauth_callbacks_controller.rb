class Users::OmniauthCallbacksController < ApplicationController
  def facebook
    @user = User.find_for_facebook_oauth request.env["omniauth.auth"]
    if @user.persisted?
      flash[:success] = 'Authentication success!'
      cookies.delete :visitor_id
      sign_in_and_redirect @user, :event => :authentication
    else
      flash[:notice] = 'authentication error'
      redirect_to root_path
    end
  end
end