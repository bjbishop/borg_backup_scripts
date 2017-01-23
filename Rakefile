require "rake/clean"

CLEAN.include "**/*launchctl.*"
CLEAN.include "/Users/bishbr/Box Sync/borg-encrypted/lock.exclusive"
CLOBBER.include "manifests/*"

desc "Create the box directory and install the req'd packages"
task :setup do
  sh("brew install lz4") unless sh("brew ls lz4 &> /dev/null")
  sh("brew install xz") unless sh("brew ls xz &> /dev/null")
  sh("brew cask install borgbackup") unless sh("brew cask ls borgbackup &> /dev/null")
  sh("brew cask install box-sync") unless sh("brew cask ls box-sync &> /dev/null")
  sh("brew install terminal-notifier") unless sh("brew ls terminal-notifier &> /dev/null")
  FileUtils.ln_sf(File.join(ENV['HOME'], "Box Sync"),
                  File.join(ENV['HOME'], "box")) unless
    File.exist?(File.join(ENV['HOME'], "box"))
  FileUtils.mkdir_p("$HOME/box/borg-encrypted")
  sh("gem install lunchy")
  sh("lunchy install borg.plist")
  sh("lunchy install borg-local.plist")
  sh("lunchy start -x borg")
  sh("lunchy start -x borg-local")
end

desc "Uninstall the services"
task :uninstall do
  sh("lunchy stop -x borg")
  sh("lunchy stop -x borg-local")
  sh("lunchy uninstall borg.plist")
  sh("lunchy uninstall borg-local.plist")
end
