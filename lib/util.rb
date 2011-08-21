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

  def self.create_diff_data
    User.all.each do |user|
      previous_count = 0
      user.pushup_histories.sort_by(&:created_at).each do |record|
        record.update_attribute :diff, (record.count - previous_count)
      end
    end
  end

  def self.fake_data
    if Rails.env == 'development'
      PushupHistory.destroy_all
      User.all.each do |user|
        dates = []
        counts = []
        data_size = (rand * 5 + 2)
        date = Date.today
        count = 0
        data_size.to_i.times do
          dates << (date -= (rand * 45 + 3).to_i.hours)
          counts << (count += rand * 2 + 1).to_i * 20
        end

        dates.reverse.zip(counts).each do |date, count|
          PushupHistory.create(:user => user, :created_at => date, :count => count, :season => 2)
        end
      end
    end
  end
end
