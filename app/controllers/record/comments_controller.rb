class Record::CommentsController < ApplicationController
  def new
    @comment = Record::Comment.new
    @competition = current_user.competitions.find(params[:competition_id])
  end

  def create
    @comment = Record::Comment.new(comment_params)
    @competition = current_user.competitions.find(params[:competition_id])
    if @comment.valid? # 手動でバリデーションの検証をする
      # @commentを、sessionに保存
      session[:record].merge!({
        comment: @comment.comment
      })
      # セッションからデータを、キーと値のペアで取り出す
      @competition_record_params = session[:record]
      # レコードを保存する
      CompetitionRecord.create!(@competition_record_params)
      # セッションをクリアにする
      session.delete(:record)
      # 大会結果詳細ページへ遷移
      redirect_to competition_path(@competition)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:record_comment).permit(:comment)
  end
end