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

  def edit
    # competitionのレコードを取得してくる
    @competition = current_user.competitions.find(params[:competition_id])
    # 取得したcompetitionのレコードに紐づくcompetition_recordレコードを取得
    @competition_record = @competition.competition_record
    # Record::WeighInモデルのインスタンスを生成し、属性にweightの値をいれる
    @weigh_in = Record::WeighIn.new(weight: @competition_record.weight)
  end

  def update
    # ユーザーが入力した値を取得
    @weigh_in = Record::WeighIn.new(weigh_in_params)
    # competitionのレコードを取得してくる
    @competition = current_user.competitions.find(params[:competition_id])
    # 取得したcompetitionのレコードに紐づくcompetition_recordレコードを取得
    @competition_record = @competition.competition_record
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
end
