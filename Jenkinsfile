// -*- mode: groovy -*-

// Only keep some recent builds and artefacts.
properties([[$class: 'jenkins.model.BuildDiscarderProperty',
             strategy: [$class: 'LogRotator',
                        numToKeepStr: '10',
                        artifactNumToKeepStr: '5']]])

// Run all stages of the operation on one node, for simplicity to begin with.
node {

    // Checkout the source of this repository. The credentials and URL are
    // stored in the configuration of the multibranch pipeline job.
    stage "Checkout source"
    checkout scm

    stage "Test"
    timeout(time: 5, unit: "MINUTES") {
        sh("py.test complicated_library_test.py")
    }

    stage "Build binary"
    sh("make")

    stage "Archive binary."
    archive([includes: "complicated_binary.deb"])

}
