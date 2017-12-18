class ReachLinters::ConfigsGenerator < Rails::Generators::Base
  source_root File.expand_path("../../../../configs", __FILE__)

  def copy_config_files
    config_files = [
      {source: '.rubocop.yml', target: '.rubocop.yml'},
      {source: '.eslintrc.json', target: '.eslintrc.json'},
      {source: '.stylelintrc.json', target: '.stylelintrc.json'}
    ]

    config_files.each do |file|
      template file[:source], file[:target], force: true
    end
  end
end