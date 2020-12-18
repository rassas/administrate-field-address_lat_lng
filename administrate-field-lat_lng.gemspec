# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "administrate-field-address_lat_lng"
  spec.version       = "1.0.0"
  spec.authors       = ["Rassas Achref"]
  spec.email         = ["rassasachref@gmail.com"]

  spec.summary       = %q{Administrate field for address/latitude/longitude}
  spec.description   = %q{Adds an Administrate::Field::AddressLatLng for viewing & editing Address/latitude/longitude fields on a map}
  spec.homepage      = "https://github.com/rassas/administrate-field-address_lat_lng"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'administrate', '>= 0.3', '< 0.15'
 
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10.3"
  spec.add_development_dependency "erubis", "~> 2.7"
end
