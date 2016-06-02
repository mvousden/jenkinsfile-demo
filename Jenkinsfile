// -*- mode: groovy -*-

// Only keep some recent builds and artefacts.
properties([[$class: 'jenkins.model.BuildDiscarderProperty',
             strategy: [$class: 'LogRotator',
                        numToKeepStr: '10',
                        artifactNumToKeepStr: '5']]])

// Run all stages of the operation on one node, for simplicity to begin with.
node {
    stage "Checkout source"
    checkout scm

    stage "Test"
    timeout(time: 5, unit: "MINUTES") {
        sh("py.test complicated_library_test.py")
    }

    stage "Build binary"
    sh("make")

    stage "Archive binary."
    step([$class: "ArtifactArchiver", artifacts: "compicated_binary.deb"])
}