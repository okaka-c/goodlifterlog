class Record::WeighInsController < ApplicationController
  before_action :set_competition
  before_action :set_competition_record, only: %i[ edit update ]
  skip_before_action :set_bottom_navi, only: %i[ new edit ]

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

  def edit
    @weigh_in = Record::WeighIn.new(weight: @competition_record.weight)
  end

  def update
    # ユーザーが入力した値を取得
    @weigh_in = Record::WeighIn.new(weigh_in_params)
    # 取得したレコードのweightの値を、@weigh_in.weightに上書きしてupdateする
    if @competition_record.update(weight: @weigh_in.weight)
      redirect_to competition_path(@competition) # 成功したら詳細ページへ遷移する
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def weigh_in_params
    params.require(:record_weigh_in).permit(:weight).merge(competition_id: params[:competition_id])
  end

  def set_competition
    @competition = current_user.competitions.find(params[:competition_id])
  end

  def set_competition_record
    @competition_record = @competition.competition_record
  end
end
