class UsersController < ApplicationController
	before_action :correct_user, only: [:edit, :update]
	before_action :logged_in_user, only: [:edit, :update]
	
  def show
    @user = User.find(params[:id])
    # ↓ここもページネーションしたい。この場所はusersコントローラーのshowアクションだから該当のviewは・・・
    @microposts = @user.microposts.order(created_at: :desc).page(params[:page])
    #エラーになるのですが、メソッドの書き方よくわからないです
    
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "こんにちは　サンプルへ　Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to @user
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    #ページネーションとして既存の数値に「.page(params[:page])」を追加
    @users = @user.following_users.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    #ページネーションとして既存の数値に「.page(params[:page])」を追加
    @users = @user.follower_users.page(params[:page])
    render 'show_follow'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :profile, :locate)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      user = User.find(params[:id])
      redirect_to root_url if user != current_user
    end
end