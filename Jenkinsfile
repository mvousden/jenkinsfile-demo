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

// Execute multiple builds in parallel.
parallel
makeFirstTarget: {
    node {
        stage "Checkout source"
        checkout scm

        stage "Build first binary"
        sh("make first")

        stage "Archive binary."
        archive([includes: "complicated_binary_first.deb"])
    }
},

makeSecondTarget: {
    node {
        stage "Checkout source"
        checkout scm

        stage "Build second binary"
        sh("make second")

        stage "Archive binary."
        archive([includes: "complicated_binary_second.deb"])
    }
},

makeThirdTarget: {
    node {
        stage "Checkout source"
        checkout scm

        stage "Build third binary"
        sh("make third")

        stage "Archive binary."
        archive([includes: "complicated_binary_third.deb"])
    }
},
failFast: false