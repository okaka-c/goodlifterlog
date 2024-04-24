class CompetitionRecordsController < ApplicationController
  before_action :set_competition
  before_action :set_competition_record, only: %i[ edit update destroy ]

  def new
    @competition_record = CompetitionRecord.new
  end

  def create
    @competition_record = CompetitionRecord.new(competition_record_params)
    if @competition_record.save
      redirect_to competition_path(@competition)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @competition_record.update(competition_record_params)
      redirect_to competition_path(@competition)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @competition_record.destroy!
    redirect_to competitions_path
  end
q
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
      :deadlift_third_attempt, :deadlift_third_attempt_result,
      :comment
    ).merge(competition_id: params[:competition_id])
  end

  def set_competition
    @competition = current_user.competitions.find(params[:competition_id])
  end

  def set_competition_record
    @competition_record = @competition.competition_record
  end
end
