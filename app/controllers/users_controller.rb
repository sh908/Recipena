class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_to root_path
  end

  def withdraw
    @user = current_user
  end

  def index
    @users = User.where(is_deleted: false).page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :name_kana, :profile_image)
  end
end
