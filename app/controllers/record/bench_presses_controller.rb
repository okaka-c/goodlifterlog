class Record::BenchPressesController < ApplicationController
  skip_before_action :set_bottom_navi, only: %i[ new edit ]
  def new
    @bench_press = Record::BenchPress.new
    @competition = current_user.competitions.find(params[:competition_id])
  end

  def create
    @bench_press = Record::BenchPress.new(bench_press_params)
    @competition = current_user.competitions.find(params[:competition_id])
    if @bench_press.valid? # 手動でバリデーションの検証をする
      session[:record].merge!({
        benchpress_first_attempt: @bench_press.benchpress_first_attempt,
        benchpress_second_attempt: @bench_press.benchpress_second_attempt,
        benchpress_third_attempt: @bench_press.benchpress_third_attempt,
        benchpress_first_attempt_result: @bench_press.benchpress_first_attempt_result,
        benchpress_second_attempt_result: @bench_press.benchpress_second_attempt_result,
        benchpress_third_attempt_result: @bench_press.benchpress_third_attempt_result
      })
      redirect_to  new_competition_deadlift_path # 次のステップへ遷移
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # competitionのレコードを取得してくる
    @competition = current_user.competitions.find(params[:competition_id])
    # 取得したcompetitionのレコードに紐づくcompetition_recordレコードを取得
    @competition_record = @competition.competition_record
    @bench_press = Record::BenchPress.new(
      benchpress_first_attempt: @competition_record.benchpress_first_attempt,
      benchpress_second_attempt: @competition_record.benchpress_second_attempt,
      benchpress_third_attempt: @competition_record.benchpress_third_attempt,
      benchpress_first_attempt_result: @competition_record.benchpress_first_attempt_result,
      benchpress_second_attempt_result: @competition_record.benchpress_second_attempt_result,
      benchpress_third_attempt_result: @competition_record.benchpress_third_attempt_result
  )
  end

  def update
    # ユーザーが入力した値を取得
    @bench_press = Record::BenchPress.new(bench_press_params)
    # competitionのレコードを取得してくる
    @competition = current_user.competitions.find(params[:competition_id])
    # 取得したcompetitionのレコードに紐づくcompetition_recordレコードを取得
    @competition_record = @competition.competition_record
    bench_press_update_params = {
      benchpress_first_attempt: @bench_press.benchpress_first_attempt,
      benchpress_second_attempt: @bench_press.benchpress_second_attempt,
      benchpress_third_attempt: @bench_press.benchpress_third_attempt,
      benchpress_first_attempt_result: @bench_press.benchpress_first_attempt_result,
      benchpress_second_attempt_result: @bench_press.benchpress_second_attempt_result,
      benchpress_third_attempt_result: @bench_press.benchpress_third_attempt_result
    }
    # 取得したレコードの値を、ユーザーが入力してきた値に上書きしてupdateする
    if @competition_record.update(bench_press_update_params)
      redirect_to competition_path(@competition) # 成功したら詳細ページへ遷移する
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def bench_press_params
    params.require(:record_bench_press).permit(
    :benchpress_first_attempt, :benchpress_first_attempt_result,
    :benchpress_second_attempt, :benchpress_second_attempt_result,
    :benchpress_third_attempt, :benchpress_third_attempt_result)
  end
end
