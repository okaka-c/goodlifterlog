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

  def edit
    @competition = current_user.competitions.find(params[:id])
  end

  def update
    @competition = current_user.competitions.find(params[:id])
    if @competition.update(competition_params)
      redirect_to competition_path(@competition)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    competition = current_user.competitions.find(params[:id])
    competition.destroy!
    redirect_to competitions_path
  end  

private

  def competition_params
    params.require(:competition).permit(:name, :venue, :date, :competition_type, :gearcategory_type, :category, :age_group, :weight_class)
  end
end
