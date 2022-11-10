class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  
  def new
    redirect_to user_path(current_user.id) if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'ログインしました'
      redirect_to user_path(@user.id), notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to tasks_path, notice: '他のユーザーへアクセスできません'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
