# frozen_string_literal: true

FactoryBot.define do
  factory :showing do
    movie { nil }
    price { nil }
    start { '2021-11-03 21:44:53' }
    finish { '2021-11-03 21:44:53' }
    time_range { '' }
  end
end
