class BooksController < ApplicationController

  def new

  end

  # def create
  #   # １.&2. データを受け取り新規登録するためのインスタンス作成
  #   book = Book.new(book_params)
  #   # 3. データをデータベースに保存するためのsaveメソッド実行
  #   book.save
  #   # 4. トップ画面へリダイレクト
  #   redirect_to '/books/index'



  def index
     @book = Book.new
     @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    
    if @book.save
      redirect_to book_path(@book.id)
      flash[:sucsess] = "Post successfully"
      
    else
      @books= Book.all
      flash[:bad] = "Failed to post"
      render :index

    end

  end

  def show
     @book = Book.find(params[:id])
  end

  def edit
     @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    
    if @book.update(book_params)
    redirect_to book_path(@book.id)
    flash[:upsucsess] = "Update successfully"
    
    else
      @books= Book.all
      render :edit
    end
    # @book = Book.new(book_params)
    # if @book.save
    #   redirect_to book_path(@book.id)
    # else
    #   @books= Book.all
    #   render :index
    # end
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト
  end

 private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
