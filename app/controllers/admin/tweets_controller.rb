class Admin::TweetsController < Admin::BaseController
  
  def index
    @tweets = Tweet.all
    @users = User.all
  end
  
  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to admin_root_path
    flash[:alert] = "tweet was delete"
  end
  
end
