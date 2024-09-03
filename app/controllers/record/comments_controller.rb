module Record
  class CommentsController < ApplicationController
    before_action :set_competition
    before_action :set_competition_record, only: %i[edit update]
    skip_before_action :set_bottom_navi, only: %i[new edit]
    before_action :hide_bottom_navi, only: %i[create update]

    def new
      @comment = Record::Comment.new
    end

    def edit
      @comment = Record::Comment.new(comment: @competition_record.comment)
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def create
      @comment = Record::Comment.new(comment_params)
      if @comment.valid?
        # rubocop:disable Performance/RedundantMerge
        session[:record].merge!({ comment: @comment.comment })
        # rubocop:enable Performance/RedundantMerge
        @competition_record_params = session[:record]
        @competition_record = CompetitionRecord.new(@competition_record_params)
        gender = current_user.profile.gender
        @competition_record.result_save(@competition_record, @competition, gender)
        session.delete(:record)
        redirect_to competition_path(@competition), success: t('.success')
      else
        flash.now[:danger] = t('.danger')
        render :new, status: :unprocessable_entity
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def update
      @comment = Record::Comment.new(comment_params)
      if @competition_record.update(comment: @comment.comment)
        redirect_to competition_path(@competition), success: t('.success')
      else
        flash.now[:danger] = t('.danger')
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
end
