class CompetitionRecordsController < ApplicationController
  before_action :set_competition
  before_action :set_competition_record, only: %i[destroy]

  def destroy
    @competition_record.destroy!
    redirect_to competition_path(@competition), success: t('.success')
  end

  private

  def set_competition
    @competition = current_user.competitions.find(params[:competition_id])
  end

  def set_competition_record
    @competition_record = @competition.competition_record
  end
end
