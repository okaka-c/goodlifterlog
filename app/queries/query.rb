class Query
  class << self
    delegate :call, to: :new
  end

  def call
    raise NotImplementedError
  end

  private

  attr_reader :relation
end