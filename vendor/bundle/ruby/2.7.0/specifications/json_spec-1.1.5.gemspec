# -*- encoding: utf-8 -*-
# stub: json_spec 1.1.5 ruby lib

Gem::Specification.new do |s|
  s.name = "json_spec".freeze
  s.version = "1.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Steve Richert".freeze]
  s.date = "2017-05-03"
  s.description = "RSpec matchers and Cucumber steps for testing JSON content".freeze
  s.email = ["steve.richert@gmail.com".freeze]
  s.homepage = "https://github.com/collectiveidea/json_spec".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.4".freeze
  s.summary = "Easily handle JSON in RSpec and Cucumber".freeze

  s.installed_by_version = "3.2.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<multi_json>.freeze, ["~> 1.0"])
    s.add_runtime_dependency(%q<rspec>.freeze, [">= 2.0", "< 4.0"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
  else
    s.add_dependency(%q<multi_json>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 2.0", "< 4.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
