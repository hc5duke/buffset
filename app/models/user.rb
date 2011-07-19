class User < ActiveRecord::Base
  has_many :services

  attr_accessible :handle, :pushup_set_count
end
