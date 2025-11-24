# -*- encoding: utf-8 -*-
# stub: grape-doorkeeper 0.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "grape-doorkeeper".freeze
  s.version = "0.0.2".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alexey Shcherbakov".freeze]
  s.date = "2014-08-28"
  s.description = "Gem for auth in grape via doorkeeper.".freeze
  s.email = ["schalexey@gmail.com".freeze]
  s.homepage = "https://github.com/fuCtor/grape-doorkeeper".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.2.2".freeze
  s.summary = "Gem for auth in grape via doorkeeper.".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<grape>.freeze, ["~> 0.9".freeze])
  s.add_runtime_dependency(%q<doorkeeper>.freeze, ["~> 1.4.0".freeze])
  s.add_development_dependency(%q<rack-test>.freeze, ["~> 0".freeze])
  s.add_development_dependency(%q<rspec>.freeze, ["~> 2.9".freeze])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7.0".freeze])
end
