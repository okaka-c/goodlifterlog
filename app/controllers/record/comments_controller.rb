class Record::CommentsController < ApplicationController
  def new
    @comment = Record::Comment.new
  end

  def create
    def create
      @comment = Record::Comment.new(comment_params)
      if @comment.valid? # 手動でバリデーションの検証をする
        # @commentを、sessionに保存
        session[:record][:comment] = @comment.comment
        # セッションからデータを、キーと値のペアで取り出す
        @competition_record_params = session[:record].slice(
          :competition_id, :weight,
          :squat_first_attempt, :squat_second_attempt, :squat_third_attempt,
          :squat_first_attempt_result, :squat_second_attempt_result, :squat_third_attempt_result,
          :benchpress_first_attempt, :benchpress_second_attempt, :benchpress_third_attempt,
          :benchpress_first_attempt_result, :benchpress_second_attempt_result, :benchpress_third_attempt_result,
          :deadlift_first_attempt, :deadlift_second_attempt, :deadlift_third_attempt,
          :deadlift_first_attempt_result, :deadlift_second_attempt_result, :deadlift_third_attempt_result,
          :comment
        )
        # レコードを保存する
        CompetitionRecord.create!(competition_record_params)
        # セッションをクリアにする
        session.delete(:record)
        # 大会結果詳細ページへ遷移
        redirect_to competition_path(@competition_record_params)
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def comment_params
    params.require(:record_comment).permit(:comment)
  end
end
