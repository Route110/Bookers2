class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy, :index]

  def top
  end

  def create
   @book = Book.new(book_params)
   @book.user_id = current_user.id
   if @book.save
   flash[:success] = "successfully"
      redirect_to @book
    else
   flash[:danger] = @book.errors.full_messages
      @books = Book.all
      render 'index'
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      flash[:notice] = "can't successfully access"
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = "successfully"
      redirect_to book_path
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.user_id = current_user.id
      @book.destroy
      redirect_to books_path
    else
      flash[:notice] = "can't successfully access"
      redirect_to user_path(current_user.id)
    end
  end

  private
  def book_params
    params.require(:book).permit(:title,:opinion)
  end

end