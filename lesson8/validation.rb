# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :data

    def validate(variable, type, *args)
      @data ||= []
      @data.push([variable, type, args])
    end
  end

  module InstanceMethods
    def valid?
      !validate!
    rescue StandardError
      false
    end

    def validate!
      self.class.data.each do |variable, type, args|
        self.class.send(:validate_presence, variable, type, args) if type == :presence
        self.class.send(:validate_format, variable, type, args) if type == :format
        self.class.send(:validate_type, variable, type, args) if type == :type
      end
    end

    protected

    def validate_presence(variable)
      raise "Переменная <#{self.class}><#{variable}> отсутствует" if instance_variable_get(variable).nil?
    end

    def validate_format(variable, args)
      raise "Неверный формат переменной <#{self.class}><#{variable}>" unless instance_variable_get(variable).match(args[0])
    end

    def validate_type(variable, type, args)
      if instance_variable_get(variable).instance_of? Array
        instance_variable_get(variable).each_with_index do |var, index|
          raise "Неверный тип переменной <#{self.class}><#{variable}><#{index}> #{type}." unless var.instance_of? args[0]
        end
      else
        unless instance_variable_get("@#{variable}".to_sym).instance_of? args[0]
          raise "Неверный тип переменной <#{self.class}><#{variable}>"
        end
      end
    end
  end
end