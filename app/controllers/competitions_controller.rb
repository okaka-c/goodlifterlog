class CompetitionsController < ApplicationController
  before_action :set_competition, only: %i[ show edit update destroy ]
  skip_before_action :set_bottom_navi, only: %i[ new edit ]

  def index
    @competitions = current_user.competitions.order(date: :desc)
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
    @competition_record = @competition.competition_record
    @competition_result = @competition_record.competition_result
  end

  def edit; end

  def update
    if @competition.update(competition_params)
      redirect_to competition_path(@competition)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @competition.destroy!
    redirect_to competitions_path
  end

private

  def competition_params
    params.require(:competition).permit(:name, :venue, :date, :competition_type, :gearcategory_type, :category, :age_group, :weight_class)
  end

  def set_competition
    @competition = current_user.competitions.find(params[:id])
  end
end