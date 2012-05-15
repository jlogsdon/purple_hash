Gem::Specification.new do |s|
  s.name      = %q<purple_hash>
  s.version   = '1.0.0'
  s.authors   = [%q<James Logsdon>]
  s.email     = %q<dwarf@girsbrain.org>
  s.date      = %q<2012-05-11>
  s.homepage  = %q<http://github.com/jlogsdon/purple_hash>
  s.licenses  = ['MIT']

  s.summary   = %q<A lightweight Configuration gem built with Hashes>

  s.add_development_dependency %q<bundler>
  s.add_development_dependency %q<rake>
  s.add_development_dependency %q<rspec>

  s.require_paths = ['lib']

  s.files = [
    'Gemfile',
    'Gemfile.lock',
    'lib/purple_hash.rb',
    'LICENSE',
    'CHANGELOG',
    'Rakefile',
    'README.md',
  ]
  s.test_files = [
    'spec/purple_hash_spec.rb',
    'spec/spec_helper.rb'
  ]
end

