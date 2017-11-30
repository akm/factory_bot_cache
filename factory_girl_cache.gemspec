
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "factory_girl_cache/version"

Gem::Specification.new do |spec|
  spec.name          = "factory_girl_cache"
  spec.version       = FactoryGirlCache::VERSION
  spec.authors       = ["akm"]
  spec.email         = ["akm2000@gmail.com"]

  spec.summary       = %q{Help to define complicated objects with factory_girl.}
  spec.description   = %q{Help to define complicated objects with factory_girl.}
  spec.homepage      = "https://github.com/akm/factory_girl_cache"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "factory_girl"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
