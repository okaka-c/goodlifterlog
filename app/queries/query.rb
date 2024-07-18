class Query
  def self.call(*args)
    new(*args).call
  end

  def call
    raise NotImplementedError
  end

  private

  attr_reader :relation
end