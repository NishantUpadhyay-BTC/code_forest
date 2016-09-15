class CallbacksController < ApplicationController
  def create
    begin
      auth = request.env["omniauth.auth"]
      session[:github_token] = auth[:credentials][:token]
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
      session[:user_id] = user.id
      redirect_to repositories_path, notice: "Signed in!"
    rescue Exception => e
      flash[:error] = e.message
      redirect_to new_user_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out!"
  end
end
