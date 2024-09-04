class QueryBuilder
  def initialize(user)
    @user = user
    @relation = user.competitions.joins(competition_record: :competition_result).where(participation_status: 0).order(date: :asc)
  end

  def with_competition_type(competition_type)
    @relation = @relation.where(competition_type:)
    self
  end

  def with_gearcategory_type(gearcategory_type)
    @relation = @relation.where(gearcategory_type:)
    self
  end

  def with_category(category)
    @relation = @relation.where(category:)
    self
  end

  def pluck_values(column)
    @relation.pluck('competitions.date', column)
  end

  private

  attr_reader :relation
end
