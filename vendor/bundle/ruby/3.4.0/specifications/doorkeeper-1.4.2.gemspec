# -*- encoding: utf-8 -*-
# stub: doorkeeper 1.4.2 ruby lib

Gem::Specification.new do |s|
  s.name = "doorkeeper".freeze
  s.version = "1.4.2".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Felipe Elias Philipp".freeze, "Piotr Jakubowski".freeze]
  s.date = "2015-03-03"
  s.description = "Doorkeeper is an OAuth 2 provider for Rails.".freeze
  s.email = ["felipe@applicake.com".freeze, "piotr.jakubowski@applicake.com".freeze]
  s.homepage = "https://github.com/doorkeeper-gem/doorkeeper".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.4.5".freeze
  s.summary = "Doorkeeper is an OAuth 2 provider for Rails.".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<railties>.freeze, [">= 3.1".freeze])
  s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.3.5".freeze])
  s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 2.99.0".freeze])
  s.add_development_dependency(%q<capybara>.freeze, ["~> 2.3.0".freeze])
  s.add_development_dependency(%q<generator_spec>.freeze, ["~> 0.9.0".freeze])
  s.add_development_dependency(%q<factory_girl>.freeze, ["~> 4.4.0".freeze])
  s.add_development_dependency(%q<timecop>.freeze, ["~> 0.7.0".freeze])
  s.add_development_dependency(%q<database_cleaner>.freeze, ["~> 1.3.0".freeze])
  s.add_development_dependency(%q<rspec-activemodel-mocks>.freeze, ["~> 1.0.0".freeze])
  s.add_development_dependency(%q<bcrypt-ruby>.freeze, ["~> 3.0.1".freeze])
  s.add_development_dependency(%q<pry>.freeze, ["~> 0.10.0".freeze])
end
