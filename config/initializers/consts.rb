# frozen_string_literal: true

IDS = %w[
  tt0232500
  tt0322259
  tt0463985
  tt1013752
  tt1596343
  tt1905041
  tt2820852
  tt4630562
].freeze

API_KEY = 'e4f33820'

def url(id)
  "http://www.omdbapi.com/?apikey=#{API_KEY}&i=#{id}"
end

def get(id)
  res = Faraday.get(url(id))
  json = JSON.parse(res.body)
  json.deep_transform_keys(&:underscore)
end

def fetch
  out = []
  IDS.each do |id|
    out << get(id)
  end
  out
end

def dump_yaml
  f = File.open('movies.yml', 'w')
  f.puts(fetch.to_yaml)
  f.close
end
