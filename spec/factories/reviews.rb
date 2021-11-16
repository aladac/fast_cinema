# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    rating { 1 }
    source { 'MyString' }
    movie { nil }
  end
end
