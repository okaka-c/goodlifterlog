class CompetitionRecordsController < ApplicationController
def new
  @competition_records = CompetitionRecord.new
  @competition = Competition.find(params[:competition_id])
end
end
