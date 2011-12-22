module OpenTerms
  class OsxIterm
    def initialize
      require 'appscript'
      extend Appscript
      @term = app("iTerm")
      @term.activate
    end

  def open commands
    commands.each do |title,command|
      session = @term.terminals[1].make(:new => :session)
      session.name.set(title.to_s)
      session.exec(:command => "/bin/bash -l")
      session.write(:text => command)
    end
  end
  end

end
