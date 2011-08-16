class PushupHistory < ActiveRecord::Base
  belongs_to :user
  validate :season, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 2
end
