README.md

require_Tree is a GitHub visualizer that uses the github api to get commit details from public repositories and then generates fractal tree images from the data using d3.js.

This application uses ruby on rails and mongoid for most of the heavy lifting. The website design was done using Twitter Bootstrap, CSS, jQuery and a little splash of CoffeeScript.

User authentication is handled by the devise gem. Cross-Origin Reosource Sharing has been enabled to allow users to create webhooks the will post additional commit details to the application whenever code is pushed to a "hooked" repository allowing your tree to continue to grow as you work on your project.

The tree drawing function is in the main.js file. The basic idea was adapted from Peter Cook -- http://prcweb.co.uk/lab/d3-tree/. I have integrated external data so that I could use the drawing algorith for data visualization. I have also added some additional options to allow for the the drawing of different types of trees.

To fork this repository, and work on it yourself, you will need to have MongoDB installed.

Starting MongoDB

To have launchd start mongodb at login:

    'ln -sfv /usr/local/opt/mongodb/*.plist ~/Library/LaunchAgents'

Then to load mongodb now:

    'launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist'