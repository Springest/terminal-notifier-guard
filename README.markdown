# TerminalNotifier for [Guard][GUARD]

terminal-notifier is a command-line tool to send Mac OS X User Notifications,
which are available in Mac OS X 10.8.

It is currently packaged as an application bundle, because `NSUserNotification`
does not work from a ‘Foundation tool’. [radar://11956694](radar://11956694)

The Notification Center _always_ uses the application’s own icon, there’s
currently no way to specify a custom icon for a notification. However, we have
supplied you with 4 different apps, each with their own icon, to represent
statuses like: failed, success, pending, and the default notify / info style
notification.

This tool will be used by [Guard][GUARD] to show the
status of commands which are executed due to filesystem changes.


## Download

Prebuilt binaries, which are code-signed and ready to use, are available from
the [downloads section](https://github.com/Springest/terminal-notifier-guard/downloads).

Or if you want to use this from
[Ruby](https://github.com/Springest/terminal-notifier-guard/tree/master/Ruby), you can
install it through RubyGems:

```
$ [sudo] gem install terminal-notifier-guard
```


## Usage

```
$ ./terminal-notifier-notify.app/Contents/MacOS/terminal-notifier -[message|group|list] [VALUE|ID|ID] [options]
$ ./terminal-notifier-failed.app/Contents/MacOS/terminal-notifier -[message|group|list] [VALUE|ID|ID] [options]
```

In order to use terminal-notifier, you have to call the binary _inside_ the
application bundle.

The Ruby gem, which wraps this tool, _does_ have a bin wrapper. If installed
you can simply do:

```
$ terminal-notifier-notify -[message|group|list] [VALUE|ID|ID] [options]
$ terminal-notifier-succes -[message|group|list] [VALUE|ID|ID] [options]
```

This will obviously be a bit slower than using the tool without the wrapper.


#### Options

At a minimum, you have to specify either the `-message` , the `-remove`
option or the `-list` option.

-------------------------------------------------------------------------------

`-message VALUE`  **[required]**

The message body of the notification.

-------------------------------------------------------------------------------

`-title VALUE`

The title of the notification. This defaults to ‘Terminal’.

-------------------------------------------------------------------------------

`-subtitle VALUE`

The subtitle of the notification.

-------------------------------------------------------------------------------

`-group ID`

Specifies the ‘group’ a notification belongs to. For any ‘group’ only _one_
notification will ever be shown, replacing previously posted notifications.

A notification can be explicitely removed with the `-remove` option, describe
below.

Examples are:

* The sender’s name to scope the notifications by tool.
* The sender’s process ID to scope the notifications by a unique process.
* The current working directory to scope notifications by project.

-------------------------------------------------------------------------------

`-remove ID`  **[required]**

Removes a notification that was previously sent with the specified ‘group’ ID,
if one exists. If used with the special group "ALL", all message are removed.

-------------------------------------------------------------------------------

`-list ID` **[required]**

Lists details about the specified ‘group’ ID. If used with the special group
"ALL", details about all currently active  messages are displayed.

The output of this command is tab-separated, which makes it easy to parse.

-------------------------------------------------------------------------------

`-activate ID`

Specifies which application should be activated when the user clicks the
notification.

You can find the bundle identifier of an application in its `Info.plist` file
_inside_ the application bundle.

Examples are:

* `com.apple.Terminal` to activate Terminal.app
* `com.apple.Safari` to activate Safari.app

-------------------------------------------------------------------------------

`-open URL`

Specifies a resource to be opened when the user clicks the notification. This
can be a web or file URL, or any custom URL scheme.

-------------------------------------------------------------------------------

`-execute COMMAND`

Specifies a shell command to run when the user clicks the notification.


## Deploying to Heroku

If you are working in a team environment with multiple developers that may not
all be using OS X, the common usage is to add something like the following to
your Gemfile:

`gem 'terminal-notifier-guard', require: false if RUBY_PLATFORM =~ /darwin/i`

However, this will spawn a slew of errors when deploying to Heroku.  It will
assume you removed the gem from the Gemfile and didn't run bundle, and will
fail your deploy.

To fix this issue, set up a new group in your Gemfile:

```ruby
group :darwin do
  gem 'terminal-notifier-guard'
end
```

Users programming on Linux or Windows can then bundle using the following:

`bundle install --without darwin`

They will only need to do this once - it will remember the setting for future
execution of bundle.

Additionally, you will need to set a configuration variable on Heroku:

`heroku config:add BUNDLE_WITHOUT='darwin [any other groups to exclude]' [--app my-app-name]`

Heroku picks up that configuration variable when it receives a git push and
excludes those gems automatically.  You can also add `development` and `test`
to the list to prevent those gems from being added in your production environment.


## License

All the works are available under the MIT license.

Copyright (C) 2012 Eloy Durán <eloy.de.enige@gmail.com>
& Wouter de Vos <wouter.de.vos@springest.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[GUARD]: https://github.com/guard/guard
