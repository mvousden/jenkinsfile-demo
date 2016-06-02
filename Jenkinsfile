// -*- mode: groovy -*-

// Only keep some recent builds and artefacts.
properties([[$class: 'jenkins.model.BuildDiscarderProperty',
             strategy: [$class: 'LogRotator',
                        numToKeepStr: '10',
                        artifactNumToKeepStr: '5']]])

stage "test"

node {
    git([url: "https://github.com/mvousden/jenkinsfile-demo.git",
         branch: "release"])
    sh("py.test complicated_library_test.py")
}
