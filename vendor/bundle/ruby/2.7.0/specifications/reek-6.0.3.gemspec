# -*- encoding: utf-8 -*-
# stub: reek 6.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "reek".freeze
  s.version = "6.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/troessner/reek/issues", "changelog_uri" => "https://github.com/troessner/reek/CHANGELOG.md", "documentation_uri" => "https://www.rubydoc.info/gems/reek", "homepage_uri" => "https://github.com/troessner/reek", "source_code_uri" => "https://github.com/troessner/reek" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Kevin Rutherford".freeze, "Timo Roessner".freeze, "Matijs van Zuijlen".freeze, "Piotr Szotkowski".freeze]
  s.date = "2021-01-11"
  s.description = "Reek is a tool that examines Ruby classes, modules and methods and reports any code smells it finds.".freeze
  s.email = ["timo.roessner@googlemail.com".freeze]
  s.executables = ["code_climate_reek".freeze, "reek".freeze]
  s.extra_rdoc_files = ["CHANGELOG.md".freeze, "License.txt".freeze]
  s.files = ["CHANGELOG.md".freeze, "License.txt".freeze, "bin/code_climate_reek".freeze, "bin/reek".freeze]
  s.homepage = "https://github.com/troessner/reek".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.md".freeze, "-x".freeze, "assets/|bin/|config/|features/|spec/|tasks/".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0".freeze)
  s.rubygems_version = "3.2.4".freeze
  s.summary = "Code smell detector for Ruby".freeze

  s.installed_by_version = "3.2.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<kwalify>.freeze, ["~> 0.7.0"])
    s.add_runtime_dependency(%q<parser>.freeze, ["~> 3.0.0"])
    s.add_runtime_dependency(%q<psych>.freeze, ["~> 3.1"])
    s.add_runtime_dependency(%q<rainbow>.freeze, [">= 2.0", "< 4.0"])
  else
    s.add_dependency(%q<kwalify>.freeze, ["~> 0.7.0"])
    s.add_dependency(%q<parser>.freeze, ["~> 3.0.0"])
    s.add_dependency(%q<psych>.freeze, ["~> 3.1"])
    s.add_dependency(%q<rainbow>.freeze, [">= 2.0", "< 4.0"])
  end
end
