class CompetitionRecordsController < ApplicationController
  def new
    @competition_records = CompetitionRecord.new
    @competition = Competition.find(params[:competition_id])
  end

  def create
    @competition_records = CompetitionRecord.new(competition_record_params)
    @competition = Competition.find(params[:competition_id])
    if @competition_records.save
      redirect_to competitions_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def competition_record_params
    params.require(:competition_record).permit(
      :weight,
      :squat_first_attempt, :squat_first_attempt_result,
      :squat_second_attempt, :squat_second_attempt_result,
      :squat_third_attempt, :squat_third_attempt_result,
      :benchpress_first_attempt, :benchpress_first_attempt_result,
      :benchpress_second_attempt, :benchpress_second_attempt_result,
      :benchpress_third_attempt, :benchpress_third_attempt_result,
      :deadlift_first_attempt, :deadlift_first_attempt_result,
      :deadlift_second_attempt, :deadlift_second_attempt_result,
      :deadlift_third_attempt, :deadlift_third_attempt_result
    ).merge(competition_id: params[:competition_id])
  end
end
