require 'spec_helper'
require 'appscript'
describe OpenTerms::OsxTerminal do
  it "should require appscript" do
    $term_mock = mock("Terminal")
    $term_mock.should_receive(:activate)
    OpenTerms::OsxIterm.new
  end
  it "should execute commands" do
    commands = [
      ["title1", "command1"],
      ["title2", "command2"]
    ]
    $term_mock = mock("Terminal")
    $system_mock = mock("System Events")
    $term_mock.should_receive :activate
    commands.each do |title,command|
      $term_mock.should_receive :activate
      $system_mock.should_receive(:application_processes).and_return({"Terminal.app" => $term_mock})
      $term_mock.should_receive(:keystroke).with("t", using: :command_down)
      tab = mock("tab #{title}")
      $term_mock.should_receive(:windows).and_return($term_mock)
      $term_mock.should_receive(:first).and_return($term_mock)
      $term_mock.should_receive(:tabs).and_return($term_mock)
      $term_mock.should_receive(:last).and_return(tab)
      tab.should_receive(:custom_title).and_return(tab)
      tab.should_receive(:set).with(title)
      $term_mock.should_receive(:do_script).with(command, in: tab)
    end
    automator = OpenTerms::OsxTerminal.new
    automator.open commands
  end
end
