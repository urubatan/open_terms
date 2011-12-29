module OpenTerms
  class GnomeTerminal
    attr_reader :term_pid
    def initialize
      @term_pid = `xdotool getactivewindow`
    end

    def open commands
      commands.each do |tab_name, command|
        run "xdotool windowfocus #{term_pid}"
        run "xdotool key ctrl+shift+t"
        run "xdotool type '#{command}'"
        run "xdotool key Return"
      end
    end

    protected

    def run(command)
      system(command) && sleep(1) || raise("Command #{command.inspect} failed")
    end
  end
end
