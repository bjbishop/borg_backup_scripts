node {
  properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '1')), pipelineTriggers([])])

  ansiColor('xterm') {
    
    def item_uuid = sh(returnStdout: true, script: 'uuidgen | tail -c 10').trim()
    def borg_home = "${env.HOME}/src/borg"
    def borg_vault = "${env.HOME}/box/borg-encrypted"
    def borg_manifests_home = "${borg_home}/manifests"
    def borg_exclude = "${borg_home}/exclude"
    def borg_options = "--exclude-from ${borg_exclude} --one-file-system --verbose --stats --compression lzma --lock-wait 60 --exclude-if-present .exclude"

    stage("Backup") {
	    sh """
        set +x

        mkdir -p ${borg_manifests_home}
        /usr/local/bin/borg create ${borg_options} "${borg_vault}"::${item_uuid} ${env.HOME} | tee ${borg_manifests_home}/${item_uuid}.txt

        """
    } // backup

    stage("Verify") {
	    def verify_options = "--repair --repository-only --lock-wait 30 --verbose"
	    sh """
        set +x

        yes YES | /usr/local/bin/borg check ${verify_options} ${borg_vault}
        """
    }

    stage("Prune") {
	    def keep_these_days = 14
	    def keep_all_within_days = "1d"
	    def prune_options = "--list --stats --verbose"
	    
	    sh """
        set +x

        mkdir -p ${borg_manifests_home}

        /usr/local/bin/borg prune ${prune_options} -d ${keep_these_days} --keep-within ${keep_all_within_days} ${borg_vault}
        find ${borg_manifests_home} -type f -mtime +${keep_these_days} -delete

        """
    } // prune

    stage("Log cleanup") {
	    sh """

        set +x
        /usr/local/bin/xz -9 ${borg_manifests_home}/${item_uuid}.txt
	"""
    } // log cleanup

	  step([$class: 'Mailer', notifyEveryUnstableBuild: true, recipients: 'bryan.bishop@pearson.com bryanjbishop1@gmail.com', sendToIndividuals: false])
  }
}
