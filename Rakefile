require 'rake/clean'

CLEAN.include 'logs/*launchctl.*'

desc "Create the box directory and install the req'd packages"
task :setup do
  sh('brew install lz4') unless sh('brew ls lz4 &> /dev/null')
  sh('brew install xz') unless sh('brew ls xz &> /dev/null')
  sh('brew cask install anybar') unless sh('brew cask ls anybar &> /dev/null')
  sh('brew cask install borgbackup') unless sh('brew cask ls borgbackup &> /dev/null')
  sh('brew cask install box-sync') unless sh('brew cask ls box-sync &> /dev/null')
  sh('brew install terminal-notifier') unless sh('brew ls terminal-notifier &> /dev/null')
  unless File.exist?(File.join(ENV['HOME'], 'box'))
    FileUtils.ln_sf(File.join(ENV['HOME'], 'Box Sync'),
                    File.join(ENV['HOME'], 'box'))
  end
  FileUtils.mkdir_p(File.join(ENV['HOME'], 'box', 'borgmatic'))
  sh('pip3 install --upgrade borgmatic')
end


namespace :service do
  desc 'Install the services'
  task :install do
    sh('gem install lunchy')  
    %w[box redsandisk sandisk].each do |b|
      sh("lunchy install #{b}.plist")
      sh("lunchy start -x #{b}")
    end
  end

  desc 'Uninstall the services'
  task :uninstall do
    %w[box redsandisk sandisk].each do |b|
      sh("lunchy uninstall -x #{b}")
    end
  end

end