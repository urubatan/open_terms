require 'rubygems'
require "open_terms/version"
require "open_terms/osx_iterm"
require "open_terms/osx_terminal"
require "open_terms/gnome_terminal"

module OpenTerms
  require "open_terms/railtie" if defined?(Rails)

  def self.run_commands(commands)
    is_osx = RUBY_PLATFORM =~ /darwin/
    if is_osx
      begin
        automator = OsxIterm.new
      rescue
        automator = OsxTerminal.new
      end
    else
      automator = GnomeTerminal.new
    end
    automator.open commands
  end

  def self.rails_defaults
    project_dir = Rails.root
    @commands = [
      [:application, %Q{cd "#{project_dir}" && script/rails server}],
      [:console, %Q{cd "#{project_dir}" && script/rails console}],
      [:logs, %Q{cd "#{project_dir}" && tail -f log/development.log}]
    ]
    self.run_commands @commands
  end
end
