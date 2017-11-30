require "factory_bot_cache/version"

require "factory_bot"

module FactoryBotCache
  module_function

  def clear
    @caches = nil
  end

  def name_for(base_name, key)
    "#{base_name}_#{key}"
  end

  def caches
    @caches ||= {}
  end

  def of(base_name)
    caches[base_name.to_sym] ||= Hash.new do |hash, key|
      hash[key] = FactoryBot.create( name_for(base_name, key) )
    end
  end

  # @return [Proc] a Proc which returns mapped id for given argument
  def id_map_of(base_name)
    lambda{|key| of(base_name)[key].id }
  end
end
