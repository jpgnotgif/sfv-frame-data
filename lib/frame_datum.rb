require File.join(File.dirname(__FILE__), './transform')

class FrameDatum
  include Transform

  attr_reader :name, :attack_level, :damage, :chip_damage, :stun
  attr_reader :cancel_ability, :startup, :active, :recovery
  attr_reader :block_advantage, :hit_advantage, :counter_hit_advantage
  attr_reader :counter_hit_damage, :counter_hit_stun, :knockdown_advantage
  attr_reader :knockdown_recovery_advantage, :knockdown_recovery_back_advantage
  attr_reader :chip_damage
  attr_reader :row

  def initialize(row)
    @row = row
    @name                              = transform(row['Move'])
    @damage                            = numberify!(row['Damage'])
    @chip_damage                       = numberify!(row['Chip'])
    @attack_level                      = normalize!(row['Attack Level'])
    @stun                              = numberify!(row['Stun'])
    @cancel_ability                    = normalize!(row['Cancel Ability'])
    @startup                           = numberify!(row['Startup'])
    @active                            = numberify!(row['Active'])
    @recovery                          = numberify!(row['Recovery'])
    @block_advantage                   = numberify!(row['Block Advantage'])
    @hit_advantage                     = numberify!(row['Hit Advantage'])
    @counter_hit_advantage             = numberify!(row['CH hit adv.'])
    @counter_hit_damage                = numberify!(row['CH Damage'])
    @counter_hit_stun                  = numberify!(row['CH Stun'])
    @knockdown_advantage               = numberify!(row['KD Adv.'])
    @knockdown_recovery_advantage      = numberify!(row['KDR Adv.'])
    @knockdown_recovery_back_advantage = numberify!(row['KDRB Adv.'])
  end

  def pretty_hashify
    name = rename_in_vsystem(@name)
    data = {
      "#{name}": {
        damage: @damage,
        chip_damage: @chip_damage,
        attack_level: @attack_level,
        stun: @stun,
        cancel_ability: @cancel_ability,
        frames: {
          startup: @startup,
          active: @active,
          recovery: @recovery,
          block_advantage: @block_advantage,
          hit_advantage: @hit_advantage,
          counter_hit_advantage: @counter_hit_advantage,
          counter_hit_damage: @counter_hit_damage,
          counter_hit_stun: @counter_hit_stun,
          knockdown_advantage: @knockdown_advantage,
          knockdown_recovery_advantage: @knockdown_recovery_advantage,
          knockdown_recovery_back_advantage: @knockdown_recovery_back_advantage
        }
      }
    }
    data
  end

  def hashify
    name = rename_with_vtrigger(@name)
    data = {
      "#{name}": {
        d: @damage,
        cd: @chip_damage,
        al: @attack_level,
        s: @stun,
        ca: @cancel_ability,
        frames: {
          s: @startup,
          a: @active,
          r: @recovery,
          ba: @block_advantage,
          ha: @hit_advantage,
          cha: @counter_hit_advantage,
          chd: @counter_hit_damage,
          chs: @counter_hit_stun,
          kda: @knockdown_advantage,
          kdra: @knockdown_recovery_advantage,
          kdrba: @knockdown_recovery_back_advantage
        }
      }
    }
    data
  end
end
