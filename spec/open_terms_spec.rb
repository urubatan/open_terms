require 'spec_helper'
require 'open_terms'
module Rails
  def self.root
    "RAILS_ROOT"
  end
end
describe OpenTerms do
  it "should open the 3 default terminals for a Rails app" do
    project_dir = "RAILS_ROOT"
    @commands = [
      [:application, %Q{cd "#{project_dir}" && script/rails server}],
      [:console, %Q{cd "#{project_dir}" && script/rails console}],
      [:logs, %Q{cd "#{project_dir}" && tail -f log/development.log}]
    ]
    OpenTerms.should_receive(:run_commands).with(@commands)
    OpenTerms.rails_defaults
  end
end
