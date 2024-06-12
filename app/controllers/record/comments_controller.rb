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
      gender = current_user.profile.gender
      @competition_record.result_save(@competition_record, @competition, gender)
      # セッションをクリアにする
      session.delete(:record)
      # 大会結果詳細ページへ遷移
      redirect_to competition_path(@competition), success: t('.success')
    else
      flash.now[:danger] = t('.danger')
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
