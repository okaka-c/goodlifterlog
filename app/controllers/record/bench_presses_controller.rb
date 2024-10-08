module Record
  class BenchPressesController < ApplicationController
    before_action :set_competition
    before_action :set_competition_record, only: %i[edit update]
    before_action :set_competition_result, only: %i[update]
    skip_before_action :set_bottom_navi, only: %i[new edit]
    before_action :hide_bottom_navi, only: %i[create update]

    def new
      @bench_press = Record::BenchPress.new
    end

    def edit
      @bench_press = Record::BenchPress.new(
        benchpress_first_attempt: @competition_record.benchpress_first_attempt,
        benchpress_second_attempt: @competition_record.benchpress_second_attempt,
        benchpress_third_attempt: @competition_record.benchpress_third_attempt,
        benchpress_first_attempt_result: @competition_record.benchpress_first_attempt_result,
        benchpress_second_attempt_result: @competition_record.benchpress_second_attempt_result,
        benchpress_third_attempt_result: @competition_record.benchpress_third_attempt_result
      )
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def create
      @bench_press = Record::BenchPress.new(bench_press_params)
      if @bench_press.valid?
        session[:record].merge!({
                                  benchpress_first_attempt: @bench_press.benchpress_first_attempt,
                                  benchpress_second_attempt: @bench_press.benchpress_second_attempt,
                                  benchpress_third_attempt: @bench_press.benchpress_third_attempt,
                                  benchpress_first_attempt_result: @bench_press.benchpress_first_attempt_result,
                                  benchpress_second_attempt_result: @bench_press.benchpress_second_attempt_result,
                                  benchpress_third_attempt_result: @bench_press.benchpress_third_attempt_result
                                })
        case @competition.category
        when 'パワーリフティング'
          redirect_to new_competition_deadlift_path, success: t('.success')
        when 'シングルベンチプレス'
          redirect_to new_competition_comment_path, success: t('.success')
        end
      else
        flash.now[:danger] = t('.danger')
        render :new, status: :unprocessable_entity
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def update
      @bench_press = Record::BenchPress.new(bench_press_params)
      bench_press_update_params = {
        benchpress_first_attempt: @bench_press.benchpress_first_attempt,
        benchpress_second_attempt: @bench_press.benchpress_second_attempt,
        benchpress_third_attempt: @bench_press.benchpress_third_attempt,
        benchpress_first_attempt_result: @bench_press.benchpress_first_attempt_result,
        benchpress_second_attempt_result: @bench_press.benchpress_second_attempt_result,
        benchpress_third_attempt_result: @bench_press.benchpress_third_attempt_result
      }
      @competition_record.assign_attributes(bench_press_update_params)
      if @competition_record.valid?
        gender = current_user.profile.gender
        @competition_record.result_save(@competition_record, @competition, gender)
        redirect_to competition_path(@competition), success: t('.success')
      else
        flash.now[:danger] = t('.danger')
        render :edit, status: :unprocessable_entity
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    private

    def bench_press_params
      params.require(:record_bench_press).permit(
        :benchpress_first_attempt, :benchpress_first_attempt_result,
        :benchpress_second_attempt, :benchpress_second_attempt_result,
        :benchpress_third_attempt, :benchpress_third_attempt_result
      )
    end

    def set_competition
      @competition = current_user.competitions.find(params[:competition_id])
    end

    def set_competition_record
      @competition_record = @competition.competition_record
    end

    def set_competition_result
      @competition_result = @competition_record.competition_result
    end
  end
end
