module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) {instance_variable_get(var_name)&.last}
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, []) unless instance_variable_get(var_name)
        instance_variable_get(var_name) << value
      end
    end
  end


  def history(*names)
    names.each do |name|
      define_method("#{name}_history".to_sym) {instance_variable_get("@#{name}".to_sym)}
      end
  end


  def strong_attr_accessor(element_rr, class_element_rr)
    var_name = "@#{element_rr}".to_sym
    define_method(element_rr) {instance_variable_get(var_name)}
    define_method("#{element_rr}=".to_sym) do |value|
      raise "Тип атрибута не принадлежит этому классу" unless value.is_a? class_element_rr
      instance_variable_set(var_name, value)
    end
  end
end