# -*- mode: groovy -*-

stage "test"

node {
    git([url: "https://github.com/mvousden/jenkinsfile-demo.git",
         branch: "release"])
    sh "py.test complicated_library_test.py"
}