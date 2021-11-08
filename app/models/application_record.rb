# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.schema
    schema_class_instance.show
  end

  def self.list_schema
    schema_class_instance.list
  end

  def self.schema_reference
    schema_class_instance.reference
  end

  def self.schema_class
    self::SCHEMA_CLASS
  end

  def self.schema_class_instance
    schema_class.new(self)
  end
end
