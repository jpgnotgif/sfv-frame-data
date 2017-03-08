module Transform
  # Note: Mapping is needed because
  # ToolAssisted's CSVS follow multiple conventions
  MAPPING ||= {
    damage:                             ['Damage', 'HIT DMG'],
    stun:                               ['Stun', 'HIT STUN'],
    hit_advantage:                      ['Hit Advantage', 'HIT ADV'],
    block_advantage:                    ['Block Advantage', 'BLK ADV'],
    counter_hit_advantage:              ['CH hit adv.', 'CH ADV'],
    counter_hit_damage:                 ['CH Damage', 'CH DMG'],
    counter_hit_stun:                   ['CH Stun', 'CH STUN'],
    knockdown_advantage:                ['KD Adv.', 'HIT KD'],
    knockdown_recovery_advantage:       ['KDR Adv.', 'HIT KDR'],
    knockdown_recovery_back_advantage:  ['KDRB Adv.', 'HIT KDBR']
  }.freeze

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
    name = name.gsub(/\s+/, '_').gsub(/(\.+)|(\(+)|(\)+)/, '').downcase
  end

  def find_value_and_normalize!(name, row)
    value = find_value(name, row)
    normalize!(value)
  end

  def normalize!(value)
    if value && !value.empty? && value != '-' && value != 'KD'
      value.to_s.downcase
    else
      nil
    end
  end

  def rename!(value)
    # TODO: Clean this up
    if value == 'vs'
      value = 'vskill'
    elsif /vs\_/.match?(value)
      value = value.gsub('vs_', '')
      value = "vskill_#{value}"
    elsif value == 'vr'
      value = 'vreversal'
    elsif /vt\_/.match?(value)
      value = value.gsub('vt_', '')
      value = "vtrigger_#{value}"
    elsif value == 'vt'
      value = 'vtrigger'
    end
    value
  end

  def find_value(name, row)
    key = MAPPING[name].find { |mapping| row[mapping] }
    row[key]
  end
end
