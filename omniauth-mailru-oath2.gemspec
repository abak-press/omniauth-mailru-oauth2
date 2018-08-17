lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'omniauth/mailru_oauth2/version'

Gem::Specification.new do |spec|
  spec.name        = 'omniauth-mailru-oauth2'
  spec.license     = 'MIT'
  spec.version     = OmniAuth::MailruOauth2::VERSION
  spec.authors     = ['Andrew Shalaev']
  spec.email       = ['isqad88@gmail.com']
  spec.homepage    = 'https://github.com/abak-press/omniauth-mailru-oauth2'
  spec.summary     = 'OmniAuth strategy for Mail.ru'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'omniauth'
  spec.add_runtime_dependency 'omniauth-oauth2'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec-rails', '>= 2.14.0'
  spec.add_development_dependency 'appraisal', '>= 1.0.2'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'test-unit'
  spec.add_development_dependency 'pry-byebug'
end
