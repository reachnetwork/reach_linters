namespace :reach_linters do
  desc 'Installs various components needed for the linters'
  task :system_setup do
    Bundler.with_clean_env do
      `sudo ls` # just want to get the sudo password out of the way for prettier output later :)

      print "\nChecking for Homebrew..."
      begin
        r = `brew list`
        raise "\nHomebrew not found!" if r.nil? || r.include?('No such file or directory')
        print " FOUND!"
      rescue StandardError => e
        print e.message
        puts "\n\nINSTALLATION FAILED!"
        exit
      end

      print "\n\nUpdating Homebrew..."
      `brew update`
      print " DONE!"

      install_node

      install_linters

      puts "\n\nSETUP COMPLETE!"
    end
  end
end

private

def install_node
  print "\n\nChecking for Node..."
  if `brew list`.include?('node')
    print " FOUND, skipping..."
  else
    print "\n INSTALLING..."
    `brew install node`
    if `brew list`.include?('node')
      print " FINISHED!"
    else
      puts "\n\nERROR: Failed to install package manager!"
      return
    end
  end
end

def install_linters
  ['PostCSS', 'StyleLint', 'ESLint'].each do |lib_name|
    print "\nChecking for #{lib_name}..."
    lib = lib_name.downcase
    if `sudo npm -g list`.include?(lib)
      print " FOUND, skipping..."
    else
      print "\n INSTALLING..."
      `sudo npm install -g #{lib}`
      if `sudo npm -g list`.include?(lib)
        print " FINISHED!"
      else
        print ' FAILED!'
      end
    end
  end
end