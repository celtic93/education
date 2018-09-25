module InstanceCounter

  def self.included(base)
    base.class_variable_set(:@@instanses, 0)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instanses
      self.class_variable_get(:@@instanses)
    end
  end

  module InstanceMethods
    
    protected

    def register_instance
      self.class.class_variable_set(:@@instanses, self.class.class_variable_get(:@@instanses) + 1)
    end
  end
end
