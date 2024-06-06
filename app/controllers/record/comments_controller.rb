class Record::CommentsController < ApplicationController
  before_action :set_competition
  before_action :set_competition_record, only: %i[ edit update ]
  skip_before_action :set_bottom_navi, only: %i[ new edit ]

  def new
    @comment = Record::Comment.new
  end

  def create
    @comment = Record::Comment.new(comment_params)
    if @comment.valid? # 手動でバリデーションの検証をする
      # @commentを、sessionに保存
      session[:record].merge!({
        comment: @comment.comment
      })
      # セッションからデータを、キーと値のペアで取り出す
      @competition_record_params = session[:record]
      # レコードを保存する
      @competition_record = CompetitionRecord.new(@competition_record_params)
      # transaction開始
      ActiveRecord::Base.transaction do
        # ステップ1 @competition_recordの内容をテーブルに保存
        @competition_record.save!

        # ステップ2ここからCompetitionResultテーブルのレコード保存のため計算開始
        # スクワットの最高重量を算出
        # 試技結果の重量を保存に成功したインスタンスから抽出
        @squat_attempt = {
          squat_first_attempt: @competition_record.squat_first_attempt,
          squat_second_attempt: @competition_record.squat_second_attempt,
          squat_third_attempt: @competition_record.squat_third_attempt
        }
        squat_attempts = []
        # 成功試技のみ、配列に格納していく
        @squat_attempt.each do |key, value|
          result_key = "#{key.to_s}_result".to_sym
          squat_attempts << value if @competition_record[result_key] == "success"
        end
        # 成功試技の中で、最高重量を変数に代入
        best_squat_weight = squat_attempts.max

        # ベンチプレスの最高重量を算出
        @benchpress_attempt = {
          benchpress_first_attempt: @competition_record.benchpress_first_attempt,
          benchpress_second_attempt: @competition_record.benchpress_second_attempt,
          benchpress_third_attempt: @competition_record.benchpress_third_attempt
        }
        benchpress_attempts = []
        # 成功試技のみ、配列に格納していく
        @benchpress_attempt.each do |key, value|
          result_key = "#{key.to_s}_result".to_sym
          benchpress_attempts << value if @competition_record[result_key] == "success"
        end
        # 成功試技の中で、最高重量を変数に代入
        best_benchpress_weight = benchpress_attempts.max

        # デッドリフトの最高重量を算出
        @deadlift_attempt = {
          deadlift_first_attempt: @competition_record.deadlift_first_attempt,
          deadlift_second_attempt: @competition_record.deadlift_second_attempt,
          deadlift_third_attempt: @competition_record.deadlift_third_attempt
        }
        deadlift_attempts = []
        # 成功試技のみ、配列に格納していく
        @benchpress_attempt.each do |key, value|
          result_key = "#{key.to_s}_result".to_sym
          deadlift_attempts << value if @competition_record[result_key] == "success"
        end
        # 成功試技の中で、最高重量を変数に代入
        best_deadlift_weight = deadlift_attempts.max

        # ３種目の合計重量の合計重量を足してトータルを出す
        total_lifted_weight = best_squat_weight + best_benchpress_weight + best_deadlift_weight

        # IPFポイントの計算をする
        # 係数a,b,cの決定
        coefficients = CompetitionResult::COEFFICIENTS[current_user.profile.gender][@competition.gearcategory_type][@competition.category]
        a = coefficients[:a]
        b = coefficients[:b]
        c = coefficients[:c]

        # 検量体重
        body_weight = @competition_record.weight
        # IPFポイント計算式
        ipf_gl_points = total_lifted_weight * 100 / (a - b * Math.exp(-c * body_weight))

        # CompetitionResultのインスタンス生成し、いままでの計算結果を代入する
        results_params = {
          competition_record_id: @competition_record.id,
          best_squat_weight: best_squat_weight,
          best_benchpress_weight: best_benchpress_weight,
          best_deadlift_weight: best_deadlift_weight,
          total_lifted_weight: total_lifted_weight,
          ipf_points: ipf_gl_points,
        }
        @competition_result = CompetitionResult.new(results_params)
        # 保存
        @competition_result.save!
      end
      # セッションをクリアにする
      session.delete(:record)
      # 大会結果詳細ページへ遷移
      redirect_to competition_path(@competition)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @comment = Record::Comment.new(comment: @competition_record.comment)
  end

  def update
    # ユーザーが入力した値を取得
    @comment = Record::Comment.new(comment_params)
    # 取得したレコードのweightの値を、@weigh_in.weightに上書きしてupdateする
    if @competition_record.update(comment: @comment.comment)
      redirect_to competition_path(@competition) # 成功したら詳細ページへ遷移する
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:record_comment).permit(:comment)
  end

  def set_competition
    @competition = current_user.competitions.find(params[:competition_id])
  end

  def set_competition_record
    @competition_record = @competition.competition_record
  end
end
