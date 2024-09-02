module Record
  class SquatsController < ApplicationController
    before_action :set_competition
    before_action :set_competition_record, only: %i[edit update]
    before_action :set_competition_result, only: %i[update]
    skip_before_action :set_bottom_navi, only: %i[new edit]
    before_action :hide_bottom_navi, only: %i[create update]

    def new
      @squat = Record::Squat.new
    end

    def edit
      @squat = Record::Squat.new(
        squat_first_attempt: @competition_record.squat_first_attempt,
        squat_second_attempt: @competition_record.squat_second_attempt,
        squat_third_attempt: @competition_record.squat_third_attempt,
        squat_first_attempt_result: @competition_record.squat_first_attempt_result,
        squat_second_attempt_result: @competition_record.squat_second_attempt_result,
        squat_third_attempt_result: @competition_record.squat_third_attempt_result
      )
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def create
      @squat = Record::Squat.new(squat_params)
      if @squat.valid?
        session[:record].merge!({
                                  squat_first_attempt: @squat.squat_first_attempt,
                                  squat_second_attempt: @squat.squat_second_attempt,
                                  squat_third_attempt: @squat.squat_third_attempt,
                                  squat_first_attempt_result: @squat.squat_first_attempt_result,
                                  squat_second_attempt_result: @squat.squat_second_attempt_result,
                                  squat_third_attempt_result: @squat.squat_third_attempt_result
                                })
        redirect_to new_competition_bench_presse_path, success: t('.success')
      else
        flash.now[:danger] = t('.danger')
        render :new, status: :unprocessable_entity
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def update
      @squat = Record::Squat.new(squat_params)
      squat_update_params = {
        squat_first_attempt: @squat.squat_first_attempt,
        squat_second_attempt: @squat.squat_second_attempt,
        squat_third_attempt: @squat.squat_third_attempt,
        squat_first_attempt_result: @squat.squat_first_attempt_result,
        squat_second_attempt_result: @squat.squat_second_attempt_result,
        squat_third_attempt_result: @squat.squat_third_attempt_result
      }
      @competition_record.assign_attributes(squat_update_params)
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

    def squat_params
      params.require(:record_squat).permit(
        :squat_first_attempt, :squat_first_attempt_result,
        :squat_second_attempt, :squat_second_attempt_result,
        :squat_third_attempt, :squat_third_attempt_result
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
