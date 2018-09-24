module InstanceCounter
  attr_accessor :instanses

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  @@instanses = {:station => 0, :train => 0, :route => 0,}

  module ClassMethods
    def instanses
      
    end
  end

  module InstanceMethods
    def register_instance
      
    end
  end
end