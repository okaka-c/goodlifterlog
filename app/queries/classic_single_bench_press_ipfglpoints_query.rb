class ClassicSingleBenchPressIpfglpointsQuery < Query
  def initialize(user)
    @user = user
  end

  def call
    QueryBuilder.new(@user)
                .with_competition_type(0)
                .with_gearcategory_type(0)
                .with_category('シングルベンチプレス')
                .pluck_values('competition_results.ipf_points')
  end
end
