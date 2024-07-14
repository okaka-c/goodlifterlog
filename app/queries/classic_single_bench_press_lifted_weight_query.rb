class ClassicSingleBenchPressLiftedWeightQuery < Query
	def initialize(user)
    @user = user
  end

  def call
    QueryBuilder.new(@user)
      .with_competition_type(0)
      .with_gearcategory_type(0)
      .with_category("シングルベンチプレス")
      .pluck_values("competition_results.total_lifted_weight")
  end
end