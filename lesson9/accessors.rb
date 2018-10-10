module Accessors
  attr_reader :history

  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        @history ||= {}
        @history[name] ||= []
        @history[name] << value
      end

      define_method("#{name}_history".to_sym) do
        raise 'Нет истории' if @history.nil? || !@history.has_key?(name) 
        @history[name]
      rescue Exception => e
        puts e
      end
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      unless value.is_a?(class_name)
        raise "Неверный класс. Введите значение класса #{class_name}"
      end

      instance_variable_set(var_name, value)
    end
  end
end
