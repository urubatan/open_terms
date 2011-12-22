namespace :terms do
  desc "Open the default commands with terminals for this application"
  task :open => :environment do
    OpenTerms.rails_defaults
  end
end
