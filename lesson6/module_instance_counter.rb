# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances
    end

    def increase_instance
      @instances = 0 if @instances.nil?
      @instances += 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.send :increase_instance
    end
  end
end
