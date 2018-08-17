require 'bundler/setup'

require 'simplecov'
SimpleCov.start do
  minimum_coverage 90
end

require 'omniauth-mailru-oauth2'
require 'pry-byebug'

