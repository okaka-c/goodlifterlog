class Record::CommentsController < ApplicationController
  skip_before_action :set_bottom_navi, only: %i[ new edit ]

  def new
    @comment = Record::Comment.new
    @competition = current_user.competitions.find(params[:competition_id])
  end

  def create
    @comment = Record::Comment.new(comment_params)
    @competition = current_user.competitions.find(params[:competition_id])
    if @comment.valid? # 手動でバリデーションの検証をする
      # @commentを、sessionに保存
      session[:record].merge!({
        comment: @comment.comment
      })
      # セッションからデータを、キーと値のペアで取り出す
      @competition_record_params = session[:record]
      # レコードを保存する
      CompetitionRecord.create!(@competition_record_params)
      # セッションをクリアにする
      session.delete(:record)
      # 大会結果詳細ページへ遷移
      redirect_to competition_path(@competition)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # competitionのレコードを取得してくる
    @competition = current_user.competitions.find(params[:competition_id])
    # 取得したcompetitionのレコードに紐づくcompetition_recordレコードを取得
    @competition_record = @competition.competition_record
    @comment = Record::Comment.new(comment: @competition_record.comment)
  end

  def update
    # ユーザーが入力した値を取得
    @comment = Record::Comment.new(comment_params)
    # competitionのレコードを取得してくる
    @competition = current_user.competitions.find(params[:competition_id])
    # 取得したcompetitionのレコードに紐づくcompetition_recordレコードを取得
    @competition_record = @competition.competition_record
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
end
