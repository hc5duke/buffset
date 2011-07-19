class User < ActiveRecord::Base
  has_many :services

  attr_accessible :pushup_set_count
end
