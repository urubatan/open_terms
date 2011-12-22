module OpenTerms
  class OsxTerminal

    def initialize
      require 'appscript'
      extend Appscript
      @term = app('Terminal')
      tab = @term.windows.first.tabs.last
      @set_titles = (@term.version.get.to_f < 2.1) && tab.properties.include?("custom_title")
    end

    def open commands
      run commands
      #set_tab_titles commands
      @term.windows.first.tabs.first.selected.set true
    end

    protected

    def run commands
      commands.each do |command|
        if command.class == Array
          (title, command) = command
        else
          title = command
        end
        tab = make_tab title
        @term.do_script(from_project_root(command), :in => tab)
      end
    end

    def set_tab_titles titles
      tabs = @term.windows.first.tabs.get
      offset = tabs.length - titles.length
      titles.each_with_index do |title, i|
        tabs[i+offset].selected.set true
        set_selected_tab_title title
      end
    end

    def from_project_root(cmd)
      "cd #{Dir.pwd} && #{cmd}"
    end

    def make_window
      @term.activate
      app("System Events").application_processes[ "Terminal.app" ].keystroke("n", :using => :command_down)
    end

    def make_tab(title=nil)
      @term.activate app("System Events").application_processes[ "Terminal.app" ].keystroke("t", :using => :command_down)
      tab = @term.windows.first.tabs.last
      tab.selected.set true
      set_selected_tab_title title if @set_titles && title
      tab
    end

    def set_selected_tab_title(title)
      @term.activate app("System Events").application_processes[ "Terminal.app" ].keystroke("T", :using => :command_down)
      @term.activate app("System Events").application_processes[ "Terminal.app" ].keystroke(title)
      @term.activate app("System Events").application_processes[ "Terminal.app" ].key_code(36)
    end

  end
end
