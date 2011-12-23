module OpenTerms
  class OsxTerminal

    def initialize
      require 'appscript'
      extend Appscript
      @term = app('Terminal')
      @term.activate
    end

    def open commands
      run commands
    end

    protected

    def run commands
      commands.each do |title,command|
        tab = make_tab title
        @term.do_script(command, :in => tab)
      end
    end

    def make_tab(title=nil)
      @term.activate app("System Events").application_processes[ "Terminal.app" ].keystroke("t", :using => :command_down)
      tab = @term.windows.first.tabs.last
      tab.custom_title.set title
      tab
    end

  end
end
