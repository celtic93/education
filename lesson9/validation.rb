module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, type, parameters = nil)
      self.validations ||= []
      self.validations << { name: name, type: type, parameters: parameters }
    end
  end

  module InstanceMethods
    def validate!
      return if self.class.validations.nil?
      self.class.validations.each do |validation|
        @value = instance_variable_get("@#{validation[:name]}")
        send("validate_#{validation[:type]}".to_sym, @value, validation[:parameters])
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def validate_presence(name, *_parameters)
      raise 'Значение не может отсутствовать' if name.to_s.strip.empty?
    end

    def validate_format(name, format)
      raise 'Невалидный номер' if name.to_s !~ format
    end

    def validate_type(name, type)
      raise "Не тот тип #{name}" unless name.is_a?(type)
    end
  end
end
