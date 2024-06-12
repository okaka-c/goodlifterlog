class Record::WeighInsController < ApplicationController
  before_action :set_competition
  before_action :set_competition_record, only: %i[ edit update ]
  before_action :set_competition_result, only: %i[ update ]
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
      case @competition.category
        when "パワーリフティング"
          redirect_to new_competition_squat_path, success: t('.success') # スクワットへ
        when "シングルベンチプレス"
          redirect_to new_competition_bench_presse_path, success: t('.success') # ベンチプレスへ
      end
    else
      flash.now[:danger] = t('.danger')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @weigh_in = Record::WeighIn.new(weight: @competition_record.weight)
  end

  def update
    # ユーザーが入力した値を取得
    @weigh_in = Record::WeighIn.new(weigh_in_params)
    weigh_in_uptate_params = {weight: @weigh_in.weight}
    # 取得したレコードの属性の値を入力フォームから受け取った値に変更する
    @competition_record.assign_attributes(weigh_in_uptate_params)
    # バリデーション実行
    if @competition_record.valid?
      gender = current_user.profile.gender
      # メソッド内でtransaction実行し、competition_recordとcompetition_result更新
      @competition_record.result_save(@competition_record, @competition, gender)
      redirect_to competition_path(@competition), success: t('.success') # 成功したら詳細ページへ遷移する
    else
      flash.now[:danger] = t('.danger')
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

  def set_competition_result
    @competition_result = @competition_record.competition_result
  end
end
