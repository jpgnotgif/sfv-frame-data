require File.join(File.dirname(__FILE__), './transform')

class FrameDatum
  include Transform

  attr_reader :name, :attack_level, :damage, :chip_damage, :stun
  attr_reader :cancel_ability, :startup, :active, :recovery
  attr_reader :block_advantage, :hit_advantage, :counter_hit_advantage
  attr_reader :counter_hit_damage, :counter_hit_stun, :knockdown_advantage
  attr_reader :knockdown_recovery_advantage, :knockdown_recovery_back_advantage
  attr_reader :chip_damage, :command
  attr_reader :row

  def initialize(row)
    @row = row
    @name                              = transform(row['Move'])
    @command                           = normalize!(row['Command'])
    @damage                            = find_value_and_normalize!(:damage, row)
    @chip_damage                       = normalize!(row['Chip'])
    @attack_level                      = normalize!(row['Attack Level'])
    @stun                              = find_value_and_normalize!(:stun, row)
    @cancel_ability                    = normalize!(row['Cancel Ability'])
    @startup                           = normalize!(row['Startup'])
    @active                            = normalize!(row['Active'])
    @recovery                          = normalize!(row['Recovery'])
    @block_advantage                   = find_value_and_normalize!(:block_advantage, row)
    @hit_advantage                     = find_value_and_normalize!(:hit_advantage, row)
    @counter_hit_advantage             = find_value_and_normalize!(:counter_hit_advantage, row)
    @counter_hit_damage                = find_value_and_normalize!(:counter_hit_damage, row)
    @counter_hit_stun                  = find_value_and_normalize!(:counter_hit_stun, row)
    @knockdown_advantage               = find_value_and_normalize!(:knockdown_advantage, row)
    @knockdown_recovery_advantage      = find_value_and_normalize!(:knockdown_recovery_advantage, row)
    @knockdown_recovery_back_advantage = find_value_and_normalize!(:knockdown_recovery_back_advantage, row)
  end

  def pretty_hashify
    name = rename!(@name)
    data = {
      "#{name}": {
        command: @command,
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
        c: @command,
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
