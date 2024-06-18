class CompetitionsController < ApplicationController
  before_action :set_competition, only: %i[ show edit update destroy ]
  before_action :set_competition_record, only: %i[ show edit update ]
  before_action :set_competition_result, only: %i[ show update ]
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
      redirect_to new_competition_weigh_in_path(@competition), success: t('.success')
    else
      flash.now[:danger] = t('.danger')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @past_competition = current_user.competitions.past_competitions(@competition.gearcategory_type, @competition.category, @competition.date ).order(date: :desc).first
    @past_competition_result = @past_competition.competition_result if @past_competition.present?
  end

  def edit; end

  def update
    @competition.assign_attributes(competition_params)
    if @competition.valid?
      ActiveRecord::Base.transaction do
        @competition.save!
        if @competition_record.present?
          gender = current_user.profile.gender
          # 計算式を呼び出し、再計算結果を返す
          ipf_gl_points_update = @competition_record.ipf_points_update(@competition_record, @competition, gender)
          @competition_result.ipf_points = ipf_gl_points_update
          @competition_result.save!
        end
      end
      redirect_to competition_path(@competition), success: t('.success')
    else
      flash.now[:danger] = t('.danger')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @competition.destroy!
    redirect_to competitions_path, success: t('.success')
  end

private

  def competition_params
    params.require(:competition).permit(:name, :venue, :date, :competition_type, :gearcategory_type, :category, :age_group, :weight_class)
  end

  def set_competition
    @competition = current_user.competitions.find(params[:id])
  end

  def set_competition_record
    @competition_record = @competition.competition_record
  end

  def set_competition_result
    @competition_result = @competition_record.competition_result if @competition_record.present?
  end
end