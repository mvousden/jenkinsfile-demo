This project exists to test some of Jenkins' pipeline features. The release and
development branches are representative of what might exist in a real project:

 - The release branch represents a stable stage of the project.
 - The development branch represents a more bleeding-edge stage that works.
 - The feature branch represents the work of someone who has gone home from
   work and left things broken.

The server_machine branch exists as a convenient way to start up a Jenkins
server, and is not part of the testing schema.

Notes
-----

Too many builds in quick succession result in "GitHub API rate limit exceeded",
meaning Jenkins can't make requests to GitHub for a while.