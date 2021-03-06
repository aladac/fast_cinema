# frozen_string_literal: true

require 'simplecov'
require 'simplecov-lcov'
require 'codacy-coverage'

SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
COVERAGE_FORMATTER = SimpleCov::Formatter::MultiFormatter.new([
                                                                SimpleCov::Formatter::HTMLFormatter,
                                                                SimpleCov::Formatter::LcovFormatter
                                                              ])

SimpleCov.start('rails') do
  enable_coverage :branch
  formatter COVERAGE_FORMATTER
end

RSpec.configure do |config|
  config.expect_with(:rspec) do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with(:rspec) do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
