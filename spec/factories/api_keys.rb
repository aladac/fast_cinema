# frozen_string_literal: true

FactoryBot.define do
  factory :api_key do
    value { 'super_secret' }
    name { 'MyString' }
  end
end
