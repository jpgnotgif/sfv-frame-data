require File.join(File.dirname(__FILE__), './transform')

class FrameDatum
  include Transform

  attr_reader :name, :attack_level, :damage, :chip_damage, :stun
  attr_reader :cancel_ability, :startup, :active, :recovery
  attr_reader :block_advantage, :hit_advantage, :counter_hit_advantage
  attr_reader :counter_hit_damage, :counter_hit_stun, :knockdown_advantage
  attr_reader :knockdown_recovery_advantage, :knockdown_recovery_back_advantage

  def initialize(row)
    @name                              = transform(row[0])
    @damage                            = row[7] || '-'
    @chip_damage                       = row[11] || '-'
    @attack_level                      = (row[12] || '-').to_s.downcase
    @stun                              = row[10] || '-'
    @cancel_ability                    = row[13] || '-'
    @startup                           = row[2] || '-'
    @active                            = row[3] || '-'
    @recovery                          = row[4] || '-'
    @block_advantage                   = row[6] || '-'
    @hit_advantage                     = row[5] || '-'
    @counter_hit_advantage             = row[14] || '-'
    @counter_hit_damage                = row[15] || '-'
    @counter_hit_stun                  = row[16] || '-'
    @knockdown_advantage               = row[17] || '-'
    @knockdown_recovery_advantage      = row[18] || '-'
    @knockdown_recovery_back_advantage = row[19] || '-'
    @vtrigger_attack                   = row[20]
  end

  def hashify
    name = (@vtrigger_attack ? "#{@name}_vtrigger" : @name).gsub(/(\()|(\))/, '')
    {
      "#{name}": {
        d: @damage,
        cd: @chip_damage,
        al: @attack_level,
        s: @stun,
        ca: @cancel_ability,
        chd: @counter_hit_damage,
        chs: @counter_hit_stun,
        frames: {
          s: @startup,
          a: @active,
          r: @recovery,
          ba: @block_advantage,
          ha: @hit_advantage,
          cha: @counter_hit_advantage,
          kda: @knockdown_advantage,
          kdra: @knockdown_recovery_advantage,
          kdrba: @knockdown_recovery_back_advantage
        }
      }
    }
  end
end
