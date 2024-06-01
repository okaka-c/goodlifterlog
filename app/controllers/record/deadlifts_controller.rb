class Record::DeadliftsController < ApplicationController
  skip_before_action :set_bottom_navi, only: %i[ new edit ]

  def new
    @deadlift = Record::Deadlift.new
    @competition = current_user.competitions.find(params[:competition_id])
  end

  def create
    @deadlift = Record::Deadlift.new(deadlift_params)
    @competition = current_user.competitions.find(params[:competition_id])
    if @deadlift.valid? # 手動でバリデーションの検証をする
      session[:record].merge!({
        deadlift_first_attempt: @deadlift.deadlift_first_attempt,
        deadlift_second_attempt: @deadlift.deadlift_second_attempt,
        deadlift_third_attempt: @deadlift.deadlift_third_attempt,
        deadlift_first_attempt_result: @deadlift.deadlift_first_attempt_result,
        deadlift_second_attempt_result: @deadlift.deadlift_second_attempt_result,
        deadlift_third_attempt_result: @deadlift.deadlift_third_attempt_result
      })
      redirect_to new_competition_comment_path # 次のステップへ遷移
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # competitionのレコードを取得してくる
    @competition = current_user.competitions.find(params[:competition_id])
    # 取得したcompetitionのレコードに紐づくcompetition_recordレコードを取得
    @competition_record = @competition.competition_record
    @deadlift = Record::Deadlift.new(
      deadlift_first_attempt: @competition_record.deadlift_first_attempt,
      deadlift_second_attempt: @competition_record.deadlift_second_attempt,
      deadlift_third_attempt: @competition_record.deadlift_third_attempt,
      deadlift_first_attempt_result: @competition_record.deadlift_first_attempt_result,
      deadlift_second_attempt_result: @competition_record.deadlift_second_attempt_result,
      deadlift_third_attempt_result: @competition_record.deadlift_third_attempt_result
    )
  end

  def update
    # ユーザーが入力した値を取得
    @deadlift = Record::Deadlift.new(deadlift_params)
    # competitionのレコードを取得してくる
    @competition = current_user.competitions.find(params[:competition_id])
    # 取得したcompetitionのレコードに紐づくcompetition_recordレコードを取得
    @competition_record = @competition.competition_record
    deadlift_update_params = {
      deadlift_first_attempt: @deadlift.deadlift_first_attempt,
      deadlift_second_attempt: @deadlift.deadlift_second_attempt,
      deadlift_third_attempt: @deadlift.deadlift_third_attempt,
      deadlift_first_attempt_result: @deadlift.deadlift_first_attempt_result,
      deadlift_second_attempt_result: @deadlift.deadlift_second_attempt_result,
      deadlift_third_attempt_result: @deadlift.deadlift_third_attempt_result
    }
    # 取得したレコードの値を、ユーザーが入力してきた値に上書きしてupdateする
    if @competition_record.update(deadlift_update_params)
      redirect_to competition_path(@competition) # 成功したら詳細ページへ遷移する
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def deadlift_params
    params.require(:record_deadlift).permit(
    :deadlift_first_attempt, :deadlift_first_attempt_result,
    :deadlift_second_attempt, :deadlift_second_attempt_result,
    :deadlift_third_attempt, :deadlift_third_attempt_result)
  end
end
