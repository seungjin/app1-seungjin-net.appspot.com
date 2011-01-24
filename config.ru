#run lambda {Rack::Response.new('Hello..').finish}

require 'appengine-rack'
require 'module/main.rb'
require 'module/shout.rb'

#AppEngine::Rack.configure_app(
#  :application => 'app1-seungjin-net',  
#  :version => 1)

run Sinatra::Application