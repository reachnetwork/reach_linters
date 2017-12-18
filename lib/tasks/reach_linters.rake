namespace :reach_linters do
  desc 'Installs various components needed for the linters'
  task :system_setup do
    Bundler.with_clean_env do
      os = :os_x

      `sudo ls` # just want to get the sudo password out of the way for prettier output later :)

      print "\nChecking for package manager..."
      `brew list`
      print " Homebrew found!"

      install_node os

      install_linters

      puts "\n\nSETUP COMPLETE!"
    end
  end

  private

  def install_node
    print "\n\nChecking for Node..."
    `brew update`
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
end