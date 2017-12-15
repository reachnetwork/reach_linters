namespace :reach_linters do
  desc 'Installs various components needed for the linters'
  task :setup do
    Bundler.with_clean_env do
      os = :os_x

      `sudo ls` # just want to get the sudo password out of the way for prettier output later :)

      print "\nChecking for package manager..."
      begin
        `brew list`
        print " Homebrew found!"
      rescue Errno::ENOENT => e
        os = :linux
        begin
          exec 'sudo apt-get'
          print " Apt-Get found!"
        rescue Errno::ENOENT => e
          raise 'Make sure a package manager is installed! (Homebrew on OSX, Apt-Get on Linux)'
        end
      end

      print "\n\nChecking for Node..."
      case os
      when :os_x
        `brew update`
        if `brew list`.include?('node')
          print " FOUND, skipping..."
        else
          print "\n INSTALLING..."
          `brew install node`
          if `brew list`.include?('node')
            print " FINISHED!"
          else
            raise 'Failed to install package manager!'
          end
        end
      when :linux
        exec 'sudo apt-get node'
        # TODO : handle error checking for this...
      end

      print "\nChecking for PostCSS..."
      if `sudo npm -g list`.include?('postcss')
        print " FOUND, skipping..."
      else
        print "\n INSTALLING..."
        `sudo npm install -g postcss`
        if `sudo npm -g list`.include?('postcss')
          print " FINISHED!"
        else
          print ' FAILED!'
        end
      end

      print "\nChecking for StyleLint..."
      if `sudo npm -g list`.include?('stylelint')
        print " FOUND, skipping..."
      else
        print "\n INSTALLING..."
        `sudo npm install -g stylelint`
        if `sudo npm -g list`.include?('stylelint')
          print " FINISHED!"
        else
          print ' FAILED!'
        end
      end

      print "\nChecking for ESLint..."
      if `sudo npm -g list`.include?('eslint')
        print " FOUND, skipping..."
      else
        print "\n INSTALLING..."
        `sudo npm install -g eslint`
        if `sudo npm -g list`.include?('eslint')
          print " FINISHED!"
        else
          print ' FAILED!'
        end
      end

      puts "\n\nSETUP COMPLETE!"
    end
  end
end