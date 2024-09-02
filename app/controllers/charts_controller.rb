class ChartsController < ApplicationController
  def index
    @user = current_user
    @classic_power_total_weights = fetch_classic_power_total_weights
    @classic_single_benchpress_weights = fetch_classic_single_benchpress_weights
    @equipped_power_total_weights = fetch_equipped_power_total_weights
    @equipped_single_benchpress_weights = fetch_equipped_single_benchpress_weights
  end

  private

  def fetch_classic_power_total_weights
    view_context.format_dates_and_weights(
      ClassicPowerliftingTotalLiftedWeightQuery.call(@user)
    )
  end

  def fetch_classic_single_benchpress_weights
    view_context.format_dates_and_weights(
      ClassicSingleBenchPressLiftedWeightQuery.call(@user)
    )
  end

  def fetch_equipped_power_total_weights
    view_context.format_dates_and_weights(
      EquippedPowerliftingTotalLiftedWeightQuery.call(@user)
    )
  end

  def fetch_equipped_single_benchpress_weights
    view_context.format_dates_and_weights(
      EquippedSingleBenchPressLiftedWeightQuery.call(@user)
    )
  end
end
