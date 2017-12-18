class ReachLinters::ConfigsGenerator < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)

  def copy_config_files
    config_files = [
      {source: 'rubocop.yml', target: '~/.rubocop.yml'},
      {source: 'eslintrc.yml', target: '~/.eslintrc.yml'},
      {source: 'stylelintrc', target: '~/.stylelintrc'}
    ]

    config_files.each do |file|
      if File.exists?(file[:target])
        say set_color("NOTE: File #{file[:target]} already exists.", :blue)
        next
      end
      template file[:source], file[:target]
    end
  end
end