require File.expand_path('../lib/unipass_api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Aleksadner Dąbrowski', 'Karol Sarnacki']
  gem.email         = ['aleksander.dabrowski@connectmedica.com', 'karol.sarnacki@connectmedica.pl']
  gem.description   = 'Unipass client API'
  gem.summary       = 'In order to use unipass API you can use it.'
  gem.homepage      = 'https://github.com/tjeden/unipass-api'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'unipass_api'
  gem.require_paths = ['lib']
  gem.version       = UnipassApi::VERSION

  gem.add_dependency 'oauth2'
  gem.add_dependency 'rake'
end
