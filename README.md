Starting MongoDB

To have launchd start mongodb at login:

    'ln -sfv /usr/local/opt/mongodb/*.plist ~/Library/LaunchAgents'
Then to load mongodb now:

    'launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist'


Include the following in user.rb if using devise:

    'class << self
      def serialize_from_session(key, salt)
        record = to_adapter.get(key[0]["$oid"])
        record if record && record.authenticatable_salt == salt
      end
    end'

Thanks djsmentya

Planning Document
https://docs.google.com/spreadsheets/d/1d0QnX3MDVQvAas679gU97cJZFClGBI52ydlDB1OMvmY/edit?usp=sharing