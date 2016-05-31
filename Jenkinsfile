node {
    git([url: "https://github.com/mvousden/jenkinsfile-demo.git",
         branch: "release"])
    sh "python complicated_library_test.py"
    properties [[$class: 'BuildDiscarderProperty', strategy: [$class: 'LogRotator', numToKeepStr: '3']]]
}
