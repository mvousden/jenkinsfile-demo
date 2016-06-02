// -*- mode: groovy -*-

// Only keep some recent builds and artefacts.
properties([[$class: 'jenkins.model.BuildDiscarderProperty',
             strategy: [$class: 'LogRotator',
                        numToKeepStr: '10',
                        artifactNumToKeepStr: '5']]])

// Run tests and builds as separate jobs.
node {

    // Checkout the source of this repository. The credentials and URL are
    // stored in the configuration of the multibranch pipeline job.
    stage "Checkout source"
    checkout scm

    stage "Test"
    timeout(time: 5, unit: "MINUTES") {
        sh("py.test complicated_library_test.py")
    }
}

node {

    stage "Checkout source"
    checkout scm

    stage "Build binary"
    sh("make")

    stage "Archive binary."
    archive([includes: "complicated_binary.deb"])

}
