class PushupHistory < ActiveRecord::Base
  belongs_to :user
  validate :season, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 2
  before_create :find_diff

private
  def find_diff
    last = user.pushup_histories.sort_by(&:created_at).last
    self.diff = count - (last ? last.count : 0)
  end
end
