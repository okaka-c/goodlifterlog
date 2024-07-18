class ChartsController < ApplicationController
  def index
    @user = current_user
    @classic_power_total_weights = view_context.format_dates_and_weights(ClassicPowerliftingTotalLiftedWeightQuery.call(@user))
    @classic_single_benchpress_weights = view_context.format_dates_and_weights(ClassicSingleBenchPressLiftedWeightQuery.call(@user))
    @equipped_power_total_weights = view_context.format_dates_and_weights(EquippedPowerliftingTotalLiftedWeightQuery.call(@user))
    @equipped_single_benchpress_weights = view_context.format_dates_and_weights(EquippedSingleBenchPressLiftedWeightQuery.call(@user))
  end
end
