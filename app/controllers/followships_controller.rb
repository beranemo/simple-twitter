class FollowshipsController < ApplicationController
  
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])
    user = User.find(params[:following_id])
    if @followship.save
      flash[:notice] = "追蹤成功"
      user.count_followers
      redirect_back(fallback_location: root_path)  # 導回上一頁
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)  # 導回上一頁
    end    
  end

  def destroy
    @followship = current_user.followships.find_by(following_id: params[:id])
    user = User.find(params[:id])
    if @followship
      @followship.destroy
      user.count_followers
      flash[:notice] = "追蹤已取消"
      redirect_back(fallback_location: root_path)  # 導回上一頁
    end    
  end
  
end
