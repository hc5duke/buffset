class User < ActiveRecord::Base
  has_many :services
  has_many :pushup_histories
  before_save :log_pushups

  attr_accessible :handle, :pushup_set_count, :active

  validate :pushup_set_count, :numericality => true, :greater_than_or_equal_to => 0, :less_than => 10000
  validate :handle, :length => { :minimum => 1, :maximum => 10}

  scope :active, :conditions => [ 'active = ?', true ], :order => [ 'handle' ]

private
  def log_pushups
    if pushup_set_count_changed?
      pushup_histories.build(:count => pushup_set_count)
    end
  end
end
