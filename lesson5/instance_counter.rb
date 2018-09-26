module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instanses
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instanses ||= 0
      self.class.instanses += 1
    end
  end
end
