require 'pry'
require 'rubygems'
require 'bacon'
require 'mocha'
require 'mocha-on-bacon'

Bacon.summary_at_exit

$:.unshift File.expand_path('../../lib', __FILE__)
require 'terminal-notifier-guard'

describe TerminalNotifier::Guard do

  describe ".available?" do
    [ '10.8', '10.10' ].each do |version|
      specify "OS X #{version} is supported" do
        described_class.stubs(:`).returns("Darwin\n", "#{version}\n")
        expect(described_class.available?).to be_truthy
        described_class.unstub(:`)
      end
    end
    [ '10.7', '10.6' ].each do |version|
      specify "OS X #{version} is not supported" do
        described_class.stubs(:`).returns("Darwin\n", "#{version}\n")
        expect(described_class.available?).to be_falsey
        described_class.unstub(:`)
      end
    end
  end

  describe ".execute" do
    it "executes the tool with the given options" do
      command = [TerminalNotifier::Guard::Notify::BIN_PATH, '-message', 'ZOMG']
      if RUBY_VERSION < '1.9'
        require 'shellwords'
        command = Shellwords.shelljoin(command)
      end
      IO.expects(:popen).with(command).yields(StringIO.new('output'))
      TerminalNotifier::Guard.execute(false, :message => 'ZOMG')
    end

    it "executes the right tool according to the type option" do
      command = [TerminalNotifier::Guard::Success::BIN_PATH, '-message', 'ZOMG']
      if RUBY_VERSION < '1.9'
        require 'shellwords'
        command = Shellwords.shelljoin(command)
      end
      IO.expects(:popen).with(command).yields(StringIO.new('output'))
      TerminalNotifier::Guard.execute(false, :message => 'ZOMG', :type => :success)
    end

    it "returns the result output of the command" do
      TerminalNotifier::Guard.execute(false, 'help' => '').should == `'#{TerminalNotifier::Guard::Notify::BIN_PATH}' -help`
    end

    it "sends a notification" do
      TerminalNotifier::Guard.expects(:execute).with(false, :message => 'ZOMG', :group => 'important stuff')
      TerminalNotifier::Guard.notify('ZOMG', :group => 'important stuff')
    end

    it "removes a notification" do
      TerminalNotifier::Guard.expects(:execute).with(false, :remove => 'important stuff')
      TerminalNotifier::Guard.remove('important stuff')
    end

    it "by default removes all the notifications" do
      TerminalNotifier::Guard.expects(:execute).with(false, :remove => 'ALL')
      TerminalNotifier::Guard.remove
    end

    it "returns `nil` if no notification was found to list info for" do
      TerminalNotifier::Guard.expects(:execute).with(false, :list => 'important stuff').returns('')
      TerminalNotifier::Guard.list('important stuff').should == nil
    end

    it "returns info about a notification posted in a specific group" do
      TerminalNotifier::Guard.expects(:execute).with(false, :list => 'important stuff').
        returns("GroupID\tTitle\tSubtitle\tMessage\tDelivered At\n" \
                "important stuff\tTerminal\t(null)\tExecute: rake spec\t2012-08-06 19:45:30 +0000")
      TerminalNotifier::Guard.list('important stuff').should == {
        :group => 'important stuff',
        :title => 'Terminal', :subtitle => nil, :message => 'Execute: rake spec',
        :delivered_at => Time.parse('2012-08-06 19:45:30 +0000')
      }
    end

    it "by default returns a list of all notification" do
      TerminalNotifier::Guard.expects(:execute).with(false, :list => 'ALL').
        returns("GroupID\tTitle\tSubtitle\tMessage\tDelivered At\n" \
                "important stuff\tTerminal\t(null)\tExecute: rake spec\t2012-08-06 19:45:30 +0000\n" \
                "(null)\t(null)\tSubtle\tBe subtle!\t2012-08-07 19:45:30 +0000")
      TerminalNotifier::Guard.list.should == [
        {
          :group => 'important stuff',
          :title => 'Terminal', :subtitle => nil, :message => 'Execute: rake spec',
          :delivered_at => Time.parse('2012-08-06 19:45:30 +0000')
        },
        {
          :group => nil,
          :title => nil, :subtitle => 'Subtle', :message => 'Be subtle!',
          :delivered_at => Time.parse('2012-08-07 19:45:30 +0000')
        }
      ]
    end
  end

  describe ".failed" do
    it "executes the 'failed' tool binary" do
      command = [TerminalNotifier::Guard::Failed::BIN_PATH, '-message', 'ZOMG']
      if RUBY_VERSION < '1.9'
        require 'shellwords'
        command = Shellwords.shelljoin(command)
      end
      IO.expects(:popen).with(command).yields(StringIO.new('output'))
      TerminalNotifier::Guard.failed('ZOMG')
    end
  end

  describe ".success" do
    it "executes the 'success' tool binary" do
      command = [TerminalNotifier::Guard::Success::BIN_PATH, '-message', 'ZOMG']
      if RUBY_VERSION < '1.9'
        require 'shellwords'
        command = Shellwords.shelljoin(command)
      end
      IO.expects(:popen).with(command).yields(StringIO.new('output'))
      TerminalNotifier::Guard.success('ZOMG')
    end
  end

  describe ".pending" do
    it "executes the 'pending' tool binary" do
      command = [TerminalNotifier::Guard::Pending::BIN_PATH, '-message', 'ZOMG']
      if RUBY_VERSION < '1.9'
        require 'shellwords'
        command = Shellwords.shelljoin(command)
      end
      IO.expects(:popen).with(command).yields(StringIO.new('output'))
      TerminalNotifier::Guard.pending('ZOMG')
    end
  end
end
