module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(check_attribute, type_validation, additional_attribute = nil)
      unless [:presence, :format, :type].include?(type_validation)
        raise ArgumentError.new("Only :presence, :format, :type for type_validation are allowed")
      end
      @validations ||= []
      @validations << [check_attribute, type_validation, additional_attribute]
    end
  end

  module InstanceMethods
    def validate!
      self.class.instance_variable_get(:@validations)&.each do |validation|
        send("#{validation[1]}_validation", *[validation[0], validation[2]].compact)
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    private

    def presence_validation(check_attribute)
      instance_var = get_variable_by_symbol(check_attribute)

      raise "#{check_attribute} не может быть nil или пустой строкой" if instance_var == nil || check_attribute == ""
    end

    def format_validation(check_attribute, format)
      if get_variable_by_symbol(check_attribute) !~ format
        raise "Неверный формат ввода для #{check_attribute}"
      end
    end

    def type_validation(check_attribute, class_type)
      unless get_variable_by_symbol(check_attribute).is_a? class_type
        raise "#{check_attribute} не является объектом класса #{class_type}"
      end
    end

    private

    def get_variable_by_symbol(symbol)
      instance_variable_get("@#{symbol}".to_sym)
    end
  end
end