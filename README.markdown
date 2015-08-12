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

### OSX 10.8 users

As of version `1.6.1`, we no longer bundle notifiers binaries in this gem. Please revert to
version `1.5.3` for OSX 10.8 support.


## Usage

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
