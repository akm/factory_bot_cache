require "factory_bot_cache/version"

require "factory_bot"

module FactoryBotCache
  module_function

  def clear
    @caches = nil
  end

  def naming_rules
    @naming_rules ||= Hash.new do |hash, base_name|
      hash[base_name] = ->(key){ "#{base_name}_#{key}" }
    end
  end

  def caches
    @caches ||= {}
  end

  def of(base_name)
    caches[base_name.to_sym] ||= Hash.new do |hash, key|
      naming_rule = naming_rules[base_name.to_sym]
      hash[key] = FactoryBot.create( naming_rule[key] )
    end
  end

  # @return [Proc] a Proc which returns mapped id for given argument
  def id_map_of(base_name)
    lambda{|key| of(base_name)[key].id }
  end
end
