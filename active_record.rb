require 'rubygems'
require 'active_support/inflector'

module ActiveRecord
  class Base

    def self.attr_accessible(*attributes)
      attributes.each do |arg|
        self.class_eval("def #{arg};@#{arg};end")
        self.class_eval("def #{arg}=(val);@#{arg}=val;end")

      end
    end

    def self.belongs_to(*attributes)
      attributes.each do |arg|
        self.class_eval("def #{arg};@#{arg};end")
        self.class_eval("def #{arg}=(val);@#{arg}=val;end")
      end
    end

    def self.has_many(*attributes)
      belongs_to_objects =[]
      attributes.each do |attr|
        belongs_to_objects << Object.const_get(attr.to_s.singularize.capitalize).new
      end
    end

    def self.validate(*attributes); end


    def self.validates(*attributes)
      validators = Array.new
      model_attributes = Array.new
      attributes.map { |attr| validators << attr if attr.is_a? Hash  }
      attributes.map { |attr| model_attributes << attr if attr.is_a? Symbol  }

      validators.each do |validator|
        validation = validator.keys[0]
        validation_value = validator.values[0]
        model_attributes.each do |model_attribute|
          self.class_eval("def validates_#{validation.to_s}_#{model_attribute.to_s};#{validation_value};end")
        end
      end

    end

    def self.accepts_nested_attributes_for(*attributes); end
  end
end
