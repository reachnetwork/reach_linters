class ReachLinters::Railtie < Rails::Railtie
  rake_tasks do
    load 'tasks/reach_linters.rake'
  end
end