class Query
  def self.call(*)
    new(*).call
  end

  def call
    raise NotImplementedError
  end

  private

  attr_reader :relation
end
