class UsersController < ApplicationController
  def show # 追加
   @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "こんにちは　サンプルへ　Welcome to the Sample App!"
      redirect_to @user # ここを修正
    else
      render 'new'
    end
  end

#編集と更新を追加
  def edit
    end
  
  def update
    if @user(user_params)
      # 保存に成功した場合はユーザページへリダイレクト
      redirect_to @user: 'プロフィールを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end


private
 #paramsにプロフィールと地域を追加

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,profile,locate)
  end
end

