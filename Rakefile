require "rake/clean"

CLEAN.include "**/*launchctl.*"
CLEAN.include "/Users/bishbr/Box Sync/borg-encrypted/lock.exclusive"
CLOBBER.include "manifests/*"

desc "Create the box directory and install the req'd packages"
task :setup do
  sh("brew install lz4") unless sh("brew ls lz4 &> /dev/null")
  FileUtils.ln_sf(File.join(ENV['HOME'], "Box Sync"),
                  File.join(ENV['HOME'], "box")) unless
    File.exist?(File.join(ENV['HOME'], "box"))
  FileUtils.mkdir_p("$HOME/box/borg-encrypted")
end
