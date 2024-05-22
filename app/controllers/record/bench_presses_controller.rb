class Record::BenchPressesController < ApplicationController
  def new
    @bench_press = Record::BenchPress.new
  end

  def create
    @bench_press = Record::BenchPress.new(bench_press_params)
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

  private

  def bench_press_params
    params.require(:record_bench_press).permit(
    :benchpress_first_attempt, :benchpress_first_attempt_result,
    :benchpress_second_attempt, :benchpress_second_attempt_result,
    :benchpress_third_attempt, :benchpress_third_attempt_result)
  end
end
