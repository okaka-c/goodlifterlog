module Record
  class WeighInsController < ApplicationController
    before_action :set_competition
    before_action :set_competition_record, only: %i[edit update]
    before_action :set_competition_result, only: %i[update]
    skip_before_action :set_bottom_navi, only: %i[new edit]
    before_action :hide_bottom_navi, only: %i[create update]

    def new
      @weigh_in = Record::WeighIn.new
    end

    def edit
      @weigh_in = Record::WeighIn.new(weight: @competition_record.weight)
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def create
      @weigh_in = Record::WeighIn.new(weigh_in_params)
      if @weigh_in.valid?
        session[:record] = {
          competition_id: @weigh_in.competition_id,
          weight: @weigh_in.weight
        }
        case @competition.category
        when 'パワーリフティング'
          redirect_to new_competition_squat_path, success: t('.success')
        when 'シングルベンチプレス'
          redirect_to new_competition_bench_presse_path, success: t('.success')
        end
      else
        flash.now[:danger] = t('.danger')
        render :new, status: :unprocessable_entity
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def update
      @weigh_in = Record::WeighIn.new(weigh_in_params)
      weigh_in_uptate_params = { weight: @weigh_in.weight }
      @competition_record.assign_attributes(weigh_in_uptate_params)
      if @competition_record.valid?
        gender = current_user.profile.gender
        @competition_record.result_save(@competition_record, @competition, gender)
        redirect_to competition_path(@competition), success: t('.success')
      else
        flash.now[:danger] = t('.danger')
        render :edit, status: :unprocessable_entity
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

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
end
