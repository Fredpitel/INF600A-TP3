# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','RPG-Simulator','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'RPG-Simulator'
  s.version = RPGSimulator::VERSION
  s.author = 'Frederic Pitel'
  s.email = 'pitel.frederic@courriel.uqam.ca'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Simulateur de jeu de role.'
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','RPG-Simulator.rdoc']
  s.rdoc_options << '--title' << 'RPG-Simulator' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'RPG-Simulator'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency ('minitest')
  s.add_runtime_dependency('gli','2.16.0')
end
