namespace :reach_linters do
  desc 'Installs various components needed for the linters'
  task :setup do
    Bundler.with_clean_env do
      os = :os_x
      print "Checking for package manager..."
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
          unless `brew list`.include?('node')
            raise 'Failed to install package manager!'
          end
        end
      when :linux
        exec 'sudo apt-get node'
        # TODO : handle error checking for this...
      end

      print "\nChecking for CSSLint..."
      if `sudo npm -g list`.include?('csslint')
        print " FOUND, skipping..."
      else
        print "\n INSTALLING..."
        `sudo npm install -g csslint`
        unless `sudo npm -g list`.include?('csslint')
          raise 'Failed to install CSSLint!'
        end
      end

      puts "\n\nSETUP COMPLETE!"
    end
  end
end