class Record::DeadliftsController < ApplicationController
  before_action :set_competition
  before_action :set_competition_record, only: %i[ edit update ]
  before_action :set_competition_result, only: %i[ update ]
  skip_before_action :set_bottom_navi, only: %i[ new edit ]

  def new
    @deadlift = Record::Deadlift.new
  end

  def create
    @deadlift = Record::Deadlift.new(deadlift_params)
    if @deadlift.valid? # 手動でバリデーションの検証をする
      session[:record].merge!({
        deadlift_first_attempt: @deadlift.deadlift_first_attempt,
        deadlift_second_attempt: @deadlift.deadlift_second_attempt,
        deadlift_third_attempt: @deadlift.deadlift_third_attempt,
        deadlift_first_attempt_result: @deadlift.deadlift_first_attempt_result,
        deadlift_second_attempt_result: @deadlift.deadlift_second_attempt_result,
        deadlift_third_attempt_result: @deadlift.deadlift_third_attempt_result
      })
      redirect_to new_competition_comment_path, success: t('.success') # 次のステップへ遷移
    else
      flash.now[:danger] = t('.danger')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @deadlift = Record::Deadlift.new(
      deadlift_first_attempt: @competition_record.deadlift_first_attempt,
      deadlift_second_attempt: @competition_record.deadlift_second_attempt,
      deadlift_third_attempt: @competition_record.deadlift_third_attempt,
      deadlift_first_attempt_result: @competition_record.deadlift_first_attempt_result,
      deadlift_second_attempt_result: @competition_record.deadlift_second_attempt_result,
      deadlift_third_attempt_result: @competition_record.deadlift_third_attempt_result
    )
  end

  def update
    # ユーザーが入力した値を取得
    @deadlift = Record::Deadlift.new(deadlift_params)
    deadlift_update_params = {
      deadlift_first_attempt: @deadlift.deadlift_first_attempt,
      deadlift_second_attempt: @deadlift.deadlift_second_attempt,
      deadlift_third_attempt: @deadlift.deadlift_third_attempt,
      deadlift_first_attempt_result: @deadlift.deadlift_first_attempt_result,
      deadlift_second_attempt_result: @deadlift.deadlift_second_attempt_result,
      deadlift_third_attempt_result: @deadlift.deadlift_third_attempt_result
    }
    # 取得したレコードの属性の値を入力フォームから受け取った値に変更する
    @competition_record.assign_attributes(deadlift_update_params)
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

  def deadlift_params
    params.require(:record_deadlift).permit(
    :deadlift_first_attempt, :deadlift_first_attempt_result,
    :deadlift_second_attempt, :deadlift_second_attempt_result,
    :deadlift_third_attempt, :deadlift_third_attempt_result)
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
