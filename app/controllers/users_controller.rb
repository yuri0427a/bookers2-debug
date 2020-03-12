class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :baria_user, only: [:update]

  def show
  	@user = User.find(params[:id])
  	@books= Book.where(user_id: @user.id)
	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
	@users = @books.all
  end

  def index
	@books= Book.where(user_id: current_user.id)
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
	@user =current_user
	@followers = @user.followers
	@followings = @user.followings
	# @relationship= Relationship.where(follewing_id: current_user.id)
  end

  def edit
	  @user = User.find(params[:id])
	  if @user.id != current_user.id
		redirect_to user_path(current_user.id)
	  end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to user_path(@user), notice: "successfully updated user!"
	  else
		
  		render "edit"
  	end
  end

  def follows
	user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @user = user.followers
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
   end

end
