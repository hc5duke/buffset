class PushupHistory < ActiveRecord::Base
  belongs_to :user
  validate :season, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 2
  before_save :find_diff

private
  def find_diff
    self.diff ||= count - user.pushup_histories.sort_by(&:created_at).last.count
  end
end
