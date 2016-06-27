module Transform
  def transform(name)
    is_normal_attack = normal_attack?(name)
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
    name = (is_normal_attack ? name.gsub(/\s+/, '') : name.gsub(/\s+/, '_')).downcase
  end

  def normal_attack?(name)
    name =~ /^stand/ ||
    name =~ /^crouch/ ||
    name =~ /^jump/
  end
end
