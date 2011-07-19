class User < ActiveRecord::Base
  has_many :services

  attr_accessible :handle, :pushup_set_count

  validate :pushup_set_count, :numericality => true, :greater_than_or_equal_to => 0, :less_than => 10000
  validate :handle, :length => { :minimum => 1, :maximum => 10}

  scope :active, :conditions => [ 'active = ?', true ], :order => [ 'handle' ]
end
