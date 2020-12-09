class BookCommentsController < ApplicationController
  def create
    # form_with model[book, book_comment]でネストurlを生成し、
    # ここへコメントデータが飛んでくる。　books/book_id/book_comment
    # 前提として、book及びuser と book_commentは1:Nの関係
    #
    # まずはいつもどおりinsertするための、下地を.newで生成
    # この飛ばし方なら、postメソッド 且つ　nest urlなので、
    # paramsに、打ち込んだコメントの内容　と　book_idが入っている。
    # コメントレコードのinsert条件は、user_id, book_id, commentが空でないこと
    # この３点をとってくるには、book_idとcommentは、paramsでおｋ
    # 残りのuser_idは、current/userにはいいている。
    # 最後に.saveし、id と timestumpが付与されて完成となる。


    # # ActionController::Parameters
    # {"utf8"=>"✓", "authenticity_token"=>"qOzrK4WhQ7qfh/2wi5uEkEXb4Au55JDmmqmqb7xZJ3qQ70diAkvfYxefOWdJ0OqyBxfcO/euu1KzhTRgsV/SOQ==",
    # "book_comment"=>{"comment"=>"おりゃあああ"}, "commit"=>"Create Book comment", "controller"=>"book_comments", "action"=>"create", "book_id"=>"1"} permitted: false>


    comment_new=BookComment.new
    comment_new.comment=book_comment_params
    comment_new.user_id=current_user.id
    comment_new.book_id=params[:book_id]
    comment_new.save

    # かっこよく書くと下のようになる。
    # comment=BookComment.new(book_comment_params)　※わかりやすくするためストロングパラメータをいじってるので、これでは動作しない。
    # comment.user_id=current_user.id
    # comment.book_id=params[:book_id]
    # comment.save

    # binding.pry

    @book=Book.find(params[:book_id])
    redirect_to book_path(@book)
  end

  def destroy
    
    # ActionController::Parameters 
    # {"_method"=>"delete", "authenticity_token"=>"qOzrK4WhQ7qfh/2wi5uEkEXb4Au55JDmmqmqb7xZJ3qQ70diAkvfYxefOWdJ0OqyBxfcO/euu1KzhTRgsV/SOQ==", 
    # "controller"=>"book_comments", "action"=>"destroy", "book_id"=>"1", "id"=>"8"} permitted: false>

    id=params[:id]
    comment_for_destroy=BookComment.find(id)
    # comment = BookComment.find(params[:id])
    comment_for_destroy.destroy
    redirect_to request.referer
  end

      private

  def book_comment_params
    comment=params.require(:book_comment).permit(:comment)
    return comment[:comment]
  end



end
