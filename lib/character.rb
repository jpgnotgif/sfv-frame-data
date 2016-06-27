class Character
  attr_accessor :health, :stun, :taunt, :jump, :jump_forward, :jump_backward
  attr_accessor :dash_forward, :dash_backward
  attr_reader :frame_data

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
      'jump backward',
      'dash forward',
      'dash backward'
    ].include?(name.downcase)
  end

  def to_json
    {
      metadata_frames: {
        h: @health,
        s: @stun,
        t: @taunt,
        j: @jump,
        jf: @jump_forward,
        jb: @jump_backward,
        df: @dash_forward,
        db: @dash_backward
      },
      attack_frames: frame_data.map(&:hashify)
    }.to_json
  end
end
