class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def create
      @book.user_id = current_user.id
      @book = Book.new(book_params)
   if @book.save
   flash[:success] = "successfully"
      redirect_to @book
    else
   flash[:danger] = @book.errors.full_messages
      @books = Book.all
      render 'index'
    end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:notice] = "can't successfully access"
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
     if @user.update(user_params)
      flash[:success] = "successfully"
      redirect_to user_path(@user.id)
     else
      render 'edit'
     end
  end

  private
  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end

end
