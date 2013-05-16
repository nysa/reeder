$LOAD_PATH << '.'
ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
require 'yaml'
require 'active_record'
require 'loofah'
require 'feedzirra'
require 'config/initializers/active_record'

autoload :Feed,       'app/models/feed'
autoload :FeedImport, 'lib/feed_import'
autoload :FeedSync,   'lib/feed_sync'