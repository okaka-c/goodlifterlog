class CompetitionsController < ApplicationController
  def index; end

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

private

  def competition_params
    params.require(:competition).permit(:name, :venue, :date, :competition_type, :gearcategory_type, :category, :age_group, :weight_class)
  end
end
