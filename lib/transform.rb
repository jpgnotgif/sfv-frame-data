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
    name = (normal_attack?(name) ? name.gsub(/\s+/, '') : name.gsub(/\s+/, '_')).downcase
  end

  def normalize!(value)
    if value && !value.empty?
      value.to_s.downcase
    else
      nil
    end
  end

  def rename_with_vtrigger(value)
    (vtrigger_attack?(value) ? "#{value}_vtrigger" : value).gsub(/(\()|(\))/, '')
  end

  def normal_attack?(name)
    /^st/.match?(name) ||
    /^cr/.match?(name) ||
    /^j/.match?(name)
  end

  def numberify!(value)
    (value =~ /\d+/) ? value.to_i : nil
  end

  private
  def vtrigger_attack?(value)
    value =~ /^vtrigger/
  end
end
