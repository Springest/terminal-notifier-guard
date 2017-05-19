# TerminalNotifier - Guard Style

A simple Ruby wrapper around the [`terminal-notifier`](https://github.com/alloy/terminal-notifier) command-line
tool, which allows you to send User Notifications to the Notification Center on
Mac OS X 10.8, or higher.

This version has 4 different icons included for each status that
[Guard][GUARD] supports:

 1. Failed
 2. Notify
 3. Pending
 4. Success


## Installation

This version depends on the official [`terminal-notifier`](https://github.com/alloy/terminal-notifier).
Install it with [Homebrew](http://brew.sh/) or see the official
[Installation instructions](https://github.com/alloy/terminal-notifier#download).

```
$ brew install terminal-notifier
```

Then, install the gem

```
$ gem install terminal-notifier-guard
```

Or add it to your Gemfile:

```ruby
gem 'terminal-notifier-guard', '~> 1.6.1'
```

## Usage

Add the notifier to your Guardfile:

```ruby
# Guardfile
notification :terminal_notifier if `uname` =~ /Darwin/
```

**Note**: The `uname` check is necessary if you have contributors to
your project who are not on OSX.

You can pass in options if you like, e.g. for the app name (used in the
title) and what app to activate when you click the notification
(defaults to Terminal.app):

```ruby
# Guardfile
notification :terminal_notifier, app_name: "MyApp ::", activate: 'com.googlecode.iTerm2' if `uname` =~ /Darwin/
```

### Configure Binary Path

You can override the binary path detection with an environment variable. This solves a problem where the default binary found by `which` is the Ruby gem version of `terminal-notifier`. This version is slow, especially in a Bundler environment.

In this scenario we would much rather use the version installed by Homebrew at `/usr/local/bin/terminal-notifier` which is noticeably faster.

This gem allows you to set an environment variable to explicitly specify the binary to use, like this:

```bash
export TERMINAL_NOTIFIER_BIN=/usr/local/bin/terminal-notifier
```

_When using guard to monitor test results in TDD, speed is of the essence. Using the right binary can save a half second or more during each test run, which doesn't seem like much but makes a big difference in productivity._

### OSX 10.8 users

As of version `1.6.1`, we no longer bundle notifier binaries in this gem. Please revert to
version `1.5.3` for OSX 10.8 support.

## Stand-alone Usage

Add following line to your Guardfile.

```ruby
notification :terminal_notifier
```

Then [Guard][GUARD] become to send Notifications to your Notification Center.

You could also use the notifier directly.

Examples are:

```ruby
TerminalNotifier::Guard.notify('Hello World')
TerminalNotifier::Guard.notify('Hello World', :title => 'Ruby', :subtitle => 'Programming Language')
TerminalNotifier::Guard.notify('Hello World', :activate => 'com.apple.Safari')
TerminalNotifier::Guard.notify('Hello World', :open => 'http://twitter.com/alloy')
TerminalNotifier::Guard.notify('Hello World', :execute => 'say "OMG"')
TerminalNotifier::Guard.notify('Hello World', :group => Process.pid)

TerminalNotifier::Guard.remove(Process.pid)

TerminalNotifier::Guard.list(Process.pid)
TerminalNotifier::Guard.list

TerminalNotifier::Guard.failed('This did not go well.')
TerminalNotifier::Guard.success('This did not go bad.')
TerminalNotifier::Guard.pending('This needs some work still')
```

## Caveats

It has been
[reported](https://github.com/Codaisseur/terminal-notifier-guard/issues/26)
that Terminal Notifier fails when run from Tmux without
`reattach-to-user-namespace` installed. See this
[comment](https://github.com/julienXX/terminal-notifier/issues/115#issuecomment-104214742) for details.

## License

All the works are available under the MIT license.

See [LICENSE][LICENSE] for details.

[HOMEPAGE]: https://github.com/Springest/terminal-notifier-guard
[GUARD]: https://github.com/guard/guard
[LICENSE]: https://github.com/Springest/terminal-notifier-guard/blob/master/LICENSE


## Contributors & Thanks to

- @alloy (For the terminal-notifier)
- @railsme (For a clean way to test for OSX version #15)
- @jamilbx (For support for local terminal-notifier command #8)
- @mattbrictson (For adding support for the TERMINAL_NOTIFIER_BIN env var)
- @goronfreeman (For the lovely icon set!)
- @bbonamin (For fixing the license issue)
- @croeck (For fixing the binary detection)
