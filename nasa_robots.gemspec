# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nasa_robots/version"

Gem::Specification.new do |spec|
  spec.name          = "nasa_robots"
  spec.version       = NasaRobots::VERSION
  spec.authors       = ["dmitry.vlasov"]
  spec.email         = ["d.vlasov.work@gmail.com"]

  spec.summary       = %q{simple robots application.}
  spec.description   = %q{Specify your plateau dimensions, robots initial positions, give each a set of instructions and see where they will eventually appear }
  spec.homepage      = "https://github.com/brver/nasa_robots"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
