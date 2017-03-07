module Transform
  def transform(name)
    return unless name
    case name
    when /stand/
      name = name.gsub(/stand/, 'st.')
    when /crouch/
      name = name.gsub(/crouch/, 'cr.')
    when /jump forward/
      name = name.gsub(/jump forward/, 'jf.')
    when /jump backward/
      name = name.gsub(/jump backward/, 'jb.')
    when /jump/
      name = name.gsub(/jump/, 'j.')
    else
      name
    end
    name = name.gsub(/\s+/, '_').gsub(/\.+/, '').downcase
  end

  def normalize!(value)
    if value && !value.empty?
      value.to_s.downcase
    else
      nil
    end
  end

  def rename_in_vsystem(value)
    if value == 'vs'
      value = 'vskill'
    elsif /vs\_\.+/.match?(value)
      value = value.gsub('vs_', '')
      value = "vskill_#{value}"
    elsif value == 'vr'
      value = 'vreversal'
    end
    value
  end

  def numberify!(value)
    (value =~ /\d+/) ? value.to_i : nil
  end
end
