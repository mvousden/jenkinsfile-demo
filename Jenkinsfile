// -*- mode: groovy -*-

// Only keep some recent builds and artefacts.
properties([[$class: 'jenkins.model.BuildDiscarderProperty',
             strategy: [$class: 'LogRotator',
                        numToKeepStr: '10',
                        artifactNumToKeepStr: '5']]])

// Build starts here. We put this in a try/except/finally block so that we can
// perform post-build actions (such as Slack notifications).
try {

    // Run tests and builds on separate nodes (potentially).
    stage "Test"
    node {

        // Checkout the source of this repository. The credentials and URL are
        // stored in the configuration of the multibranch pipeline job.
        checkout scm

        timeout(time: 5, unit: "MINUTES") {
            sh("py.test complicated_library_test.py")
        }
    }

    // Execute multiple builds in parallel. Each of these targets runs on a
    // different executor. Built objects will be archived successfully, even if
    // other parallel targets fail (because failFast is False).
    //
    // Unfortunately, these objects will not be available as "last successful"
    // artefacts. It is also not possible to build certain targets
    // individually, meaning a failed job will need to be re-run in its
    // entirety to build one artefact that previously failed.
    stage "Build and archive binaries"
    parallel makeFirstTarget: {
        node {
            checkout scm
            sh("make first")
            archive([includes: "complicated_binary_first.deb"])
        }
    }, makeSecondTarget: {
        node {
            checkout scm
            sh("make second")
            archive([includes: "complicated_binary_second.deb"])
        }
    }, makeThirdTarget: {
        node {
            checkout scm
            sh("make third")
            archive([includes: "complicated_binary_third.deb"])
        }
    }, failFast: false
}

// Postbuild stuff
finally {

    // Add Slack notification. We don't run this on a separate executor since
    // it's a small job. The token is stored on the Jenkins server (in
    // private).

    // String token = new File("/var/lib/jenkins/slack-token").text
    slackSend channel: '#general', color: 'good', message: 'Build Successful',
              teamDomain: 'jenkinsfile-demo', token: 'CRLkwfq2SLiqAn0q9PPtaRdP'
}