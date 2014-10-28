# -*- encoding: utf-8 -*-
require File.expand_path('../lib/terminal-notifier-guard', __FILE__)

Gem::Specification.new do |gem|
  gem.name             = "terminal-notifier-guard"
  gem.version          = TerminalNotifier::Guard::VERSION
  gem.summary          = 'Send User Notifications on Mac OS X 10.8 - with status icons.'
  gem.authors          = ["Eloy Duran", "Wouter de Vos"]
  gem.email            = ["wouter@springest.com"]
  gem.homepage         = 'https://github.com/Springest/terminal-notifier-guard'

  gem.files            = ['lib/terminal-notifier-guard.rb']
  gem.require_paths    = ['lib','icons']

  gem.extra_rdoc_files = ['README.markdown']

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'bacon'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'mocha-on-bacon'
end
