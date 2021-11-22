# frozen_string_literal: true

describe 'Movies', type: :request do
  subject!(:movie) { create(:movie) }

  describe 'multiple rating requests' do
    before do
      allow(Rails.cache).to(receive(:fetch).and_return(true))
    end

    it 'fail because of duplicate' do
      post rate_movie_path(movie.id, rating: 1)
      expect(response.code.to_i).to(eq(429))
    end
  end

  describe 'inavlid rating requests' do
    before do
      review = build(:review)
      allow(review).to(receive(:save).and_return(false))
      allow(Review).to(receive(:new).and_return(review))
    end

    it 'fails because value out of range' do
      post rate_movie_path(movie.id, rating: 11)
      expect(response.code.to_i).to(eq(422))
    end
  end

  path '/movies' do
    get 'List movies' do
      tags 'Movies'
      produces 'application/json'
      response '200', 'Movie list' do
        schema Movie.list_schema

        run_test! do |response|
          expect(response.body).to(
            eq(Movie.all.to_json)
          )
        end
      end
    end
  end

  path '/movies/{id}' do
    let(:id) { movie.id }

    get 'Get movie' do
      tags 'Movies'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, required: true

      response '200', 'Movie result' do
        schema Movie.schema_reference

        run_test! do |response|
          expect(response.body).to(
            eq(movie.to_json)
          )
        end
      end
    end

    path '/movies/{id}/review/{rating}' do
      let(:id) { movie.id }
      let(:rating) { rand(1..4) }

      post 'Review movie' do
        tags 'Movies'
        produces 'application/json'
        parameter name: :id, in: :path, type: :integer, required: true
        parameter name: :rating, in: :path, type: :integer, required: true

        response '204', 'Rating success' do
          run_test!
        end
      end
    end
  end
end
