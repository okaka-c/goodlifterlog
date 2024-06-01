class Record::SquatsController < ApplicationController
skip_before_action :set_bottom_navi, only: %i[ new edit ]

  def new
    @squat = Record::Squat.new
    @competition = current_user.competitions.find(params[:competition_id])
  end

  def create
    @squat = Record::Squat.new(squat_params)
    @competition = current_user.competitions.find(params[:competition_id])
    if @squat.valid? # 手動でバリデーションの検証をする
      session[:record].merge!({
        squat_first_attempt: @squat.squat_first_attempt,
        squat_second_attempt: @squat.squat_second_attempt,
        squat_third_attempt: @squat.squat_third_attempt,
        squat_first_attempt_result: @squat.squat_first_attempt_result,
        squat_second_attempt_result: @squat.squat_second_attempt_result,
        squat_third_attempt_result: @squat.squat_third_attempt_result
      })
      redirect_to new_competition_bench_presse_path # 次のステップへ遷移
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # competitionのレコードを取得してくる
    @competition = current_user.competitions.find(params[:competition_id])
    # 取得したcompetitionのレコードに紐づくcompetition_recordレコードを取得
    @competition_record = @competition.competition_record
    @squat = Record::Squat.new(
		squat_first_attempt: @competition_record.squat_first_attempt,
    squat_second_attempt: @competition_record.squat_second_attempt,
    squat_third_attempt: @competition_record.squat_third_attempt,
    squat_first_attempt_result: @competition_record.squat_first_attempt_result,
    squat_second_attempt_result: @competition_record.squat_second_attempt_result,
    squat_third_attempt_result: @competition_record.squat_third_attempt_result
  )
	end

  def update
    # ユーザーが入力した値を取得
    @squat = Record::Squat.new(squat_params)
    # competitionのレコードを取得してくる
    @competition = current_user.competitions.find(params[:competition_id])
    # 取得したcompetitionのレコードに紐づくcompetition_recordレコードを取得
    @competition_record = @competition.competition_record
    squat_update_params = {
      squat_first_attempt: @squat.squat_first_attempt,
      squat_second_attempt: @squat.squat_second_attempt,
      squat_third_attempt: @squat.squat_third_attempt,
      squat_first_attempt_result: @squat.squat_first_attempt_result,
      squat_second_attempt_result: @squat.squat_second_attempt_result,
      squat_third_attempt_result: @squat.squat_third_attempt_result
    }
    # 取得したレコードの値を、ユーザーが入力してきた値に上書きしてupdateする
    if @competition_record.update(squat_update_params)
      redirect_to competition_path(@competition) # 成功したら詳細ページへ遷移する
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def squat_params
    params.require(:record_squat).permit(
    :squat_first_attempt, :squat_first_attempt_result,
    :squat_second_attempt, :squat_second_attempt_result,
    :squat_third_attempt, :squat_third_attempt_result)
  end
end

