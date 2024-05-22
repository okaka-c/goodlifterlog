class Record::SquatsController < ApplicationController
  def new
    @squat = Record::Squat.new
  end

  def create
    @squat = Record::Squat.new(squat_params)
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

  private

  def squat_params
    params.require(:record_squat).permit(
    :squat_first_attempt, :squat_first_attempt_result,
    :squat_second_attempt, :squat_second_attempt_result,
    :squat_third_attempt, :squat_third_attempt_result)
  end
end
