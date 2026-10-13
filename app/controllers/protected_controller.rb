class ProtectedController < ApplicationController
  before_action :require_login

  def show
    @user = User.find(session[:user_id])
  end

  private

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: "You must log in first"
    end
  end
end