class Record::WeighInsController < ApplicationController
  skip_before_action :set_bottom_navi, only: %i[ new edit ]

  def new
    @weigh_in = Record::WeighIn.new
    @competition = current_user.competitions.find(params[:competition_id])
  end

  def create
    @weigh_in = Record::WeighIn.new(weigh_in_params)
    @competition = current_user.competitions.find(params[:competition_id])
    if @weigh_in.valid? # 手動でバリデーションの検証をする
      session[:record] = {
        competition_id: @weigh_in.competition_id,
        weight: @weigh_in.weight
      }
      redirect_to new_competition_squat_path # 次のステップへ遷移
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def weigh_in_params
    params.require(:record_weigh_in).permit(:weight).merge(competition_id: params[:competition_id])
  end
end
