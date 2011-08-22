class Fixnum
  # starting with 10, use Roman
  def tallyize(use_v_for_5=false, is_json=false)
    if self > 0
      ones = self % 10
      str = [ (self - ones).romanize, ' ' ]
      if ones >= 5
        if use_v_for_5
          str << 'V'
        elsif is_json
          str << "_V_"
        else
          str << "\314\266/" * 4
        end
        str << ' '
        ones -= 5
      end
      str << '/' * ones
      str.join('').strip
    else
      "0"
    end
  end

  def romanize
    raise 'too strong' if self > 9999
    str = []
    num = self
    s, num = fives(num, 1000, 'M', "\342\206\201", "\342\206\202")
    str << s
    s, num = fives(num, 100, 'C', 'D', 'M')
    str << s
    s, num = fives(num, 10, 'X', 'L', 'C')
    str << s

    str.join(' ')
  end

private

  def fives(num, unit, one, five, ten)
    str = []
    c = num / unit
    if c == 9
      str << one << ten
      num -= 9 * unit
    elsif c >= 5
      str << five
      num -= 5 * unit
    elsif c == 4
      str << one << five
      num -= 4 * unit
    end
    c = num / unit
    c.times{ str << one }
    num -= c * unit
    [str.join(''), num]
  end
end
