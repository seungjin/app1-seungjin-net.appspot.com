#run lambda {Rack::Response.new('Hello..').finish}

require 'appengine-rack'

#AppEngine::Rack.configure_app(
#  :application => 'app1-seungjin-net',  
#  :version => 1)

require 'guestbook/guestbook.rb'

run Sinatra::Application