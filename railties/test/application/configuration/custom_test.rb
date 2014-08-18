require 'application/configuration/base_test'

class ApplicationTests::ConfigurationTests::CustomTest < ApplicationTests::ConfigurationTests::BaseTest
  test 'configuration top level can be chained' do
    add_to_config <<-RUBY
      config.resque.inline_jobs = :always
      config.resque.timeout     = 60
    RUBY
    require_environment

    assert_equal :always, Rails.configuration.resque.inline_jobs
    assert_equal 60, Rails.configuration.resque.timeout
    assert_nil Rails.configuration.resque.nothing
  end

  test 'configuration top level accept normal values' do
    add_to_config <<-RUBY
      config.timeout = 60
    RUBY
    require_environment

    assert_equal 60, Rails.configuration.timeout
  end

  test 'configuration top level builds options from hashes' do
    add_to_config <<-RUBY
      config.resque = { timeout: 60, inline_jobs: :always }
    RUBY
    require_environment

    assert_equal :always, Rails.configuration.resque.inline_jobs
    assert_equal 60, Rails.configuration.resque.timeout
    assert_nil Rails.configuration.resque.nothing
  end

  test 'configuration top level builds options from hashes with string keys' do
    add_to_config <<-RUBY
      config.resque = { 'timeout' => 60, 'inline_jobs' => :always }
    RUBY
    require_environment

    assert_equal :always, Rails.configuration.resque.inline_jobs
    assert_equal 60, Rails.configuration.resque.timeout
    assert_nil Rails.configuration.resque.nothing
  end
end
