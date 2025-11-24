# -*- encoding: utf-8 -*-
# stub: grape_on_rails_routes 0.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "grape_on_rails_routes".freeze
  s.version = "0.3.2".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["syedmusamah".freeze]
  s.date = "2017-05-27"
  s.description = "View routes for all Grape API's mounted on Rails".freeze
  s.email = ["syed@thredup.com".freeze]
  s.homepage = "https://github.com/syedmusamah/grape_on_rails_routes".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.10".freeze
  s.summary = "Grape API routes".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<rails>.freeze, [">= 3.1.1".freeze])
  s.add_development_dependency(%q<rspec>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<grape>.freeze, [">= 0".freeze])
end
