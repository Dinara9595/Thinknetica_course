module InstanceCounter
  module ClassMethods
    def instances
      if @all
        @all.size
      else
        0
      end
    end
  end

  private

  module InstanceMethods
    def register_instance
      self.class.instances
    end
  end
end