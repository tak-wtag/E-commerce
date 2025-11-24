# -*- encoding: utf-8 -*-
# stub: grape 0.17.0 ruby lib

Gem::Specification.new do |s|
  s.name = "grape".freeze
  s.version = "0.17.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Michael Bleigh".freeze]
  s.date = "2016-07-29"
  s.description = "A Ruby framework for rapid API development with great conventions.".freeze
  s.email = ["michael@intridea.com".freeze]
  s.homepage = "https://github.com/ruby-grape/grape".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.1".freeze
  s.summary = "A simple Ruby framework for building REST-like APIs.".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<rack>.freeze, [">= 1.3.0".freeze])
  s.add_runtime_dependency(%q<mustermann19>.freeze, ["~> 0.4.3".freeze])
  s.add_runtime_dependency(%q<rack-accept>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<activesupport>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<multi_json>.freeze, [">= 1.3.2".freeze])
  s.add_runtime_dependency(%q<multi_xml>.freeze, [">= 0.5.2".freeze])
  s.add_runtime_dependency(%q<hashie>.freeze, [">= 2.1.0".freeze])
  s.add_runtime_dependency(%q<virtus>.freeze, [">= 1.0.0".freeze])
  s.add_runtime_dependency(%q<builder>.freeze, [">= 0".freeze])
end
