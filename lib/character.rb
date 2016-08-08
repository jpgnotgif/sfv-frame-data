class Character
  attr_reader :name, :frame_data
  attr_accessor :health, :stun, :taunt, :jump, :jump_forward, :jump_backwards
  attr_accessor :dash_forward, :dash_backwards
  attr_accessor :move_list_url

  def initialize(name)
    @name = name
    @frame_data = []
  end

  def metadata_row?(name)
    [
      'health',
      'stun',
      'taunt',
      'jump',
      'jump forward',
      'jump backwards',
      'dash forward',
      'dash backwards'
    ].include?(name.downcase)
  end

  def metadata
    @metadata ||= {
      h: @health || '-',
      s: @stun || '-',
      t: @taunt || '-',
      j: @jump || '-',
      jf: @jump_forward,
      jb: @jump_backwards,
      df: @dash_forward,
      db: @dash_backwards
    }
  end

  def moves
    attack_frames.map { |frame_data| frame_data.keys }.flatten
  end

  def attack_frames
    frame_data.map(&:hashify)
  end

  def to_json
    {
      metadata_frames: metadata,
      attack_frames: attack_frames,
      move_list_url: move_list_url
    }.to_json
  end
end
