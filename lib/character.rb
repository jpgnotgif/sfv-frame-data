class Character
  attr_reader :name, :frame_data
  attr_accessor :health, :stun

  def initialize(name)
    @name = name
    @frame_data = {}
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
      h: @health,
      s: @stun,
    }
  end

  def to_json
    {
      metadata: pretty_metadata,
      attacks: @frame_data,
    }.to_json
  end
end
