# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :data

    def validate(name, type, *args)
      @data ||= []
      @data.push([name, type, args])
    end
  end

  module InstanceMethods
    def valid?
      !validate!
    rescue StandardError
      false
    end

    def validate!
      self.class.data.each do |name, type, args|
        validate_presence(name, type, args) if type == :presence
        validate_format(name, type, args) if type == :format
        validate_type(name, type, args) if type == :type
      end
    end

    protected

    def validate_presence(name, type, args)
      raise "Переменная <#{self.class}><#{name}> отсутствует" if instance_variable_get("@#{name}".to_sym).nil?
    end

    def validate_format(name, type, args)
      raise "Неверный формат переменной <#{self.class}><#{name}>" unless instance_variable_get("@#{name}".to_sym).match(args[0])
    end

    def validate_type(name, type, args)
      if instance_variable_get("@#{name}".to_sym).instance_of? Array
        instance_variable_get("@#{name}".to_sym).each_with_index do |var, index|
          raise "Неверный тип переменной <#{self.class}><#{name}><#{index}> #{type}." unless var.instance_of? args[0]
        end
      else
        unless instance_variable_get("@#{name}".to_sym).instance_of? args[0]
          raise "Неверный тип переменной <#{self.class}><#{name}>"
        end
      end
    end
  end
end