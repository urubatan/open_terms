require 'rails'
module OpenTerms
  class Railtie < Rails::Railtie
    railtie_name :open_terms

    rake_tasks do
      load "rake/open_terms.rake"
    end
  end
end
