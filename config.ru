#run lambda {Rack::Response.new('Hello..').finish}

require 'appengine-rack'

require 'guestbook/guestbook.rb'

#AppEngine::Rack.configure_app(
#  :application => 'app1-seungjin-net',  
#  :version => 1)

run Sinatra::Application