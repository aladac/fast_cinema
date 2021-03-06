# frozen_string_literal: true

describe 'Showtimes', type: :request do
  subject!(:showing) { create :showing, start: Time.zone.now.at_beginning_of_week + 1.day }

  path '/showtime' do
    get 'List showtimes' do
      tags     'Showtime'
      produces 'application/json'

      response '200', 'Showing list' do
        schema Schemas::Showtimes.new.list

        run_test! do |response|
          expect(response.body).to(
            eq(Showing.showtime.to_json)
          )
        end
      end
    end

    get 'List showtimes' do
      tags     'Showtime'
      produces 'application/json'

      let(:start) { Time.current.at_beginning_of_week.to_s }
      let(:finish) { Time.current.at_end_of_week.to_s }

      parameter name: :start, in: :query, type: :string, description: 'Time from'
      parameter name: :finish, in: :query, type: :string, description: 'Time to'

      response '200', 'Showing list' do
        schema Schemas::Showtimes.new.list

        run_test! do |response|
          expect(response.body).to(
            eq(Showing.showtime.to_json)
          )
        end
      end
    end
  end
end
