class Admin::UsersController < ApplicationController
  before_action :check_admin, only: %i[:destroy, :edit]
  before_action :set_user, only: %i[show edit destroy update]
  skip_before_action :login_required, only: %i[:new, :create]

  def index
    @users = User.all.order(id: :asc)
    @users = @users.page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to(admin_users_path)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def destroy
    if @user.destroy
      redairect_to(admin_users_path)
    else
      redairect_to admin_users_path, notice: "管理者がいなくなるので削除できません"
    end
  end

  private

  def check_admin
    if logged_in?
      redirect_to(root_path) unless current_user.admin?
    else
      redirect_to(new_session_path)
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
