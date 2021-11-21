# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :data

    def validate(type, *args)
      @data ||= []
      @data.push([type, args])
    end
  end

  module InstanceMethods
    def valid?
      !validate!
    rescue StandardError
      false
    end

    def validate!
      self.class.data.each do |type, var, args|
        send("validate_#{type}", var, args)
      end
    end

    protected

    def validate_presence(var, args)
      raise "Переменная <#{self.class}><#{var}> отсутствует" if instance_variable_get("@#{var[0]}".to_sym).nil?
    end

    def validate_format(var, args)
      raise "Неверный формат переменной <#{self.class}><#{var}>" unless instance_variable_get("@#{var[0]}".to_sym).match(var[1])
    end

    def validate_type(var, args)
      if instance_variable_get("@#{var[0]}".to_sym).instance_of? Array
        instance_variable_get("@#{var[0]}".to_sym).each do |variable|
          raise "Неверный тип переменной <#{self.class}><#{variable}>" unless variable.instance_of? var[1]
        end
      else
        unless instance_variable_get("@#{var[0]}".to_sym).instance_of? var[1]
          raise "Неверный тип переменной <#{self.class}><#{var}>"
        end
      end
    end
  end
end