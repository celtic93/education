module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, parameters = nil)
      @validations ||= []
      @validations << { name: name, type: type, parameters: parameters }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        value = instance_variable_get("@#{validation[:name]}")
        send(validation[:type].to_sym, value, validation[:parameters])
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def presence(name, *_parameters)
      raise 'Значение не может отсутствовать' if name.to_s.strip.empty?
    end

    def format(name, format)
      raise 'Неверный формат номера' if name.to_s !~ format
    end

    def type(name, type, *_parameters)
      raise 'Не тот тип' unless name.is_a?(type)
    end
  end
end
