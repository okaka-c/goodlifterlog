module Record
  class Comment
    include ActiveModel::Model
    include ActiveModel::Attributes
    attribute :comment, :string, default: nil
  end
end
