# frozen_string_literal: true

FactoryBot.define do
  factory :showing do
    movie
    price
    start { '2021-11-03 21:44:53' }
    finish { '2021-11-03 21:44:53' }
  end
end
