say "Yield head in application layout for cache helper"
insert_into_file Rails.root.join("app/views/layouts/application.html.erb").to_s, "\n    <%= yield :head %>", before: /\s*<\/head>/

if Rails.application.config.respond_to?(:assets)
  say "Add Turbo include tags in application layout"
  insert_into_file Rails.root.join("app/views/layouts/application.html.erb").to_s, "\n    <%= turbo_include_tags %>", before: /\s*<\/head>/
end

say "Enable redis in bundle"
uncomment_lines "Gemfile", %(gem 'redis')

say "Switch development cable to use redis"
gsub_file "config/cable.yml", /development:\n\s+adapter: async/, "development:\n  adapter: redis\n  url: redis://localhost:6379/1"
