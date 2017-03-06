class Character
  attr_reader :name, :frame_data
  attr_accessor :health, :stun

  def initialize(name)
    @name = name
    @frame_data = []
  end

  def metadata_row?(name)
    [
      'health',
      'stun',
    ].include?(name.downcase)
  end

  def pretty_metadata
    @metadata ||= {
      health: @health,
      stun: @stun,
    }
  end

  def metadata
    @metadata ||= {
      h: @health || '-',
      s: @stun || '-',
    }
  end

  def moves
    attack_frames.map { |frame_data| frame_data.keys }.flatten
  end

  def attack_frames
    frame_data.map(&:pretty_hashify)
  end

  def to_json
    {
      metadata: pretty_metadata,
      attacks: attack_frames,
    }.to_json
  end
end
