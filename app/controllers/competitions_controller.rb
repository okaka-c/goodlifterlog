class CompetitionsController < ApplicationController
  def index
    @competitions = Competition.all
  end

  def new
    @competition = Competition.new
  end

  def create
    @competition = current_user.competitions.build(competition_params)
    if @competition.save
      redirect_to competitions_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @competition = Competition.find(params[:id])
    @competition_record = @competition.competition_record
  end

private

  def competition_params
    params.require(:competition).permit(:name, :venue, :date, :competition_type, :gearcategory_type, :category, :age_group, :weight_class)
  end
end
