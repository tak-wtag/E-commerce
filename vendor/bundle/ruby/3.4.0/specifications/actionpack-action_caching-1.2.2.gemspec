# -*- encoding: utf-8 -*-
# stub: actionpack-action_caching 1.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "actionpack-action_caching".freeze
  s.version = "1.2.2".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/rails/actionpack-action_caching/issues", "changelog_uri" => "https://github.com/rails/actionpack-action_caching/blob/v1.2.2/CHANGELOG.md", "documentation_uri" => "https://www.rubydoc.info/gems/actionpack-action_caching/1.2.2", "source_code_uri" => "https://github.com/rails/actionpack-action_caching/tree/v1.2.2" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["David Heinemeier Hansson".freeze]
  s.date = "2021-05-10"
  s.description = "Action caching for Action Pack (removed from core in Rails 4.0)".freeze
  s.email = "david@loudthinking.com".freeze
  s.homepage = "https://github.com/rails/actionpack-action_caching".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "3.2.15".freeze
  s.summary = "Action caching for Action Pack (removed from core in Rails 4.0)".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<actionpack>.freeze, [">= 4.0.0".freeze])
  s.add_development_dependency(%q<mocha>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<activerecord>.freeze, [">= 4.0.0".freeze])
end
