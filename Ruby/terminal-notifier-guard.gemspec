# -*- encoding: utf-8 -*-
plist = File.expand_path('../../Terminal Notifiers/notify/Terminal Notifier/Terminal Notifier-Info.plist', __FILE__)
version = `/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' '#{plist}'`.strip

Gem::Specification.new do |gem|
  gem.name             = "terminal-notifier-guard"
  gem.version          = version
  gem.summary          = 'Send User Notifications on Mac OS X 10.8 - with status icons.'
  gem.authors          = ["Eloy Duran", "Wouter de Vos"]
  gem.email            = ["wouter.de.vos@springest.com"]
  gem.homepage         = 'https://github.com/foxycoder/terminal-notifier'

  gem.executables      = ['terminal-notifier-notify', 'terminal-notifier-success', 'terminal-notifier-failed', 'terminal-notifier-pending']
  gem.files            = ['lib/terminal-notifier-guard.rb'] + Dir.glob('lib/terminal_notifier/**/*') + Dir.glob('bin/terminal-notifier-*') + Dir.glob('vendor/terminal-notifier/**/*')
  gem.require_paths    = ['lib']

  gem.extra_rdoc_files = ['README.markdown']

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'bacon'
  gem.add_development_dependency 'rspec-core'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'mocha-on-bacon'
end
