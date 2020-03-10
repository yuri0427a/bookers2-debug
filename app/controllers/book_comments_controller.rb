class BookCommentsController < ApplicationController
    def create
        @book_comment = BookComment.new(book_comment_params)
        @book_comment.user_id=current_user.id
        @book_comment.book_id=params[:book_id]
        if @book_comment.save
            flash[:notice]="投稿できました"
            redirect_to book_path(@book_comment.book_id)
        else
            flash[:alert] = "メッセージを入力してください"
            redirect_to book_path(@book_comment.book_id)
        end
    end

    def destroy
        comment = BookComment.find(params[:book_id])
        comment.destroy
        redirect_to book_path(comment.book_id)
    end
private
def book_comment_params
    params.require(:book_comment).permit(:comment, :user_id, :book_id)
end

end
