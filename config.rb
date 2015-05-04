activate :deploy do |deploy|
  deploy.method = :git
  # Optional Settings
  deploy.remote   = 'https://github.com/litigation/litigation.github.io.git' # remote name or git url, default: origin
  deploy.branch   = 'master' # default: gh-pages
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
  # deploy.commit_message = 'custom-message'      # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`
end

module ToolboxHelpers
  def categories
    @categories ||= begin
      File.open("data.json", "r") do |f|
        JSON.parse(f.read)["categories"]
      end
    end
  end

  def tags
    @tags ||= categories.map {|c|
      c['wrappers'].map {|w|
        w['tags']
      }
    }.flatten.uniq.sort_by(&:downcase)
  end

end

helpers ToolboxHelpers

configure :development do
  activate :livereload
end

# Build-specific configuration
configure :build do
end
