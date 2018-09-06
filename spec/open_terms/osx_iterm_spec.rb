require 'spec_helper'
require 'appscript'
describe OpenTerms::OsxIterm do
  it "should require appscript" do
    $term_mock = double("iTerm")
    $term_mock.should_receive(:activate)
    OpenTerms::OsxIterm.new
  end
  it "should execute commands" do
    commands = [
      ["title1", "command1"],
      ["title2", "command2"]
    ]
    $term_mock = double("iTerm")
    $term_mock.should_receive(:activate)
    session_creator = double("session_creator")
    session1 = double("session")
    name_mock = double("name")
    name_mock.should_receive(:set).with("title1")
    name_mock.should_receive(:set).with("title2")
    session_creator.should_receive(:make).twice.with(new: :session).and_return(session1)
    session1.should_receive(:name).and_return(name_mock)
    session1.should_receive(:exec).with(:command => "/bin/bash -l")
    session1.should_receive(:write).with(:text => "command1")
    session1.should_receive(:name).and_return(name_mock)
    session1.should_receive(:exec).with(:command => "/bin/bash -l")
    session1.should_receive(:write).with(:text => "command2")
    session_array = [session_creator, session_creator]
    $term_mock.should_receive(:terminals).twice.and_return(session_array)
    automator = OpenTerms::OsxIterm.new
    automator.open commands
  end
end
