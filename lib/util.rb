class Util
  def self.set_seasons
    date_range_conditions = ['created_at > ? and created_at < ?',
      Date.parse('2011-08-31'),
      Date.parse('2011-07-01')]
    PushupHistory.find(:all, :conditions => date_range_conditions) do |history|
      history.update_attribute(:season, 2)
    end
  end

  def self.migrate_johnny
    old_johnny = User.find(3)
    new_johnny = User.find(12)

    old_johnny.pushup_histories.each do |hist|
      hist.user = new_johnny
      hist.save!
    end

    new_johnny.update_attribute :active, true
    old_johnny.update_attribute :active, false
  end
end
