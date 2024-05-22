class Record::WeighInsController < ApplicationController
  def new
    @weigh_in = Record::WeighIn.new
  end

  def create
    @weigh_in = Record::WeighIn.new(weigh_in_params)
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
    params.require(:record_weigh_in).permit(:weight, :competition_id)
  end
end
