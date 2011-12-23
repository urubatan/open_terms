require 'spec_helper'
require 'open_terms/gnome_terminal'
module Kernel
  def `(args)
    $executor.run(args)
  end
  def system(args)
    $executor.run(args)
    1
  end
end
describe OpenTerms::GnomeTerminal do
  it "should get the pid for the active terminal" do
    $executor = mock("kernel")
    $executor.should_receive(:run).with('xdotool getactivewindow').and_return(2)
    OpenTerms::GnomeTerminal.new.term_pid.should == 2
  end

  it "should run commands when asked" do
    commands = [
      ["title1", "command1"],
      ["title2", "command2"]
    ]
    $executor = mock("kernel")
    $executor.should_receive(:run).with('xdotool getactivewindow').and_return(2)
    execs = ["xdotool windowfocus 2",
             "xdotool key ctrl+shift+t",
             "xdotool key ctrl+shift+alt+t",
             "xdotool type title1",
             "xdotool key Return",
             "xdotool type command1",
             "xdotool key space",
             "xdotool key Return",
             "xdotool windowfocus 2",
             "xdotool key ctrl+shift+t",
             "xdotool key ctrl+shift+alt+t",
             "xdotool type title2",
             "xdotool key Return",
             "xdotool type command2",
             "xdotool key space",
             "xdotool key Return"].each do |cmd|
      $executor.should_receive(:run).with(cmd)
             end
    automator = OpenTerms::GnomeTerminal.new
    automator.open commands
  end
end
