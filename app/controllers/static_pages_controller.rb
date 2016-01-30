class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      #ページネーションとして既存の数値に「.page(params[:page])」を追加
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page])
    end
  end
end
