# OpenTerm

This gem makes it easy to open many terminal tabs for OSX and Linux, the main idea is that working on Rails, Python, Node or other types of projects, the developer allways needs to open the same terminal windows. So why not automate this?

In a projects I worked on, there was a term.rb file, this was the first "gem" for this project. I need to write some tests, and need help testing it on linux.

This version is just a extraction from that code, this is not official yet, I'm putting it on Github only to ask some friends to help testing on Linux, since I do not have any linux box right now.

If you want to use this gem on linux, do not forget to install "xdotool" first, using your distribution package tool.

To use it on OSX you will need the "rb-appscript" gem installed.

To use on a Rails project, add these two lines on your Gemfile:

```ruby
gem 'open_terms'
gem 'rb-appscript' if RUBY_PLATFORM =~ /darwin/
```

Now you can run:

```
rake terms:open
```

If you want to run it without Rake:

```ruby
require 'open_terms'
require 'rb-appscript' if RUBY_PLATFORM =~ /darwin/
OpenTerms.rails_defaults
```

If you are not in a Rails project:

```ruby
require 'open_terms'
require 'appscript' if RUBY_PLATFORM =~ /darwin/
project_dir = File.expand_path(File.dirname(__FILE__))
@commands = [
  [:application, %Q{cd "#{project_dir}" && start_your_app_command}],
  [:console, %Q{cd "#{project_dir}" && open_your_console_command}],
  [:logs, %Q{cd "#{project_dir}" && tail -f log/development.log}]
]
OpenTerms.run_commands @commands
```

