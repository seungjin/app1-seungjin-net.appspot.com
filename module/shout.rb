require 'sinatra'
require 'dm-core'

# Configure DataMapper to use the App Engine datastore 
DataMapper.setup(:default, "appengine://auto")

# Create your model class
class Shout
  include DataMapper::Resource
  
  property :id, Serial
  property :message, Text
  property :created_at, DateTime, :default => Time.now
  property :updated_at, DateTime, :default => Time.now
end

# Make sure our template can use <%=h
helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

get '/' do
  'appengine, jruby, sinatra work'
end

post '/' do
  'appengine, jruby, sinatra work'
end

get '/shout!' do
  # Just list all the shouts
  @shouts = Shout.all(:order => [:created_at.desc])
  #@shouts = Shout.all
  erb :index
end

post '/shout!' do
  # Create a new shout and redirect back to the list.
  shout = Shout.create(:message => params[:message])
  redirect '/shout!'
end

__END__

@@ index
<html>
  <head>
    <title>Shout</title>
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
    <META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
    <!-- Copyright (C) 2005, 2006, 2007, 2008, 2009, 2010 seungjin.net -->
    <!--link rel="alternate" type="application/rss+xml" href="/Journals/form=feed&amp;size=40" title="RSS Feed, seungjin.net" /-->
    <meta name="date" content="<%=h Time.now.strftime("%Y-%m-%d %H:%M:%S %Z") %>">
    <meta name="author" content="Kim, Seung-jin">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=yes" />
    <link href="/styles/update.css" rel="stylesheet" type="text/css">
  </head>
  <body style="font-family: sans-serif;">
    <h2>Shout!</h2>
    <hr/>
    <form method=post>
      <textarea name="message" rows="3" style="width:80%"></textarea>
      <input type=submit value=Shout>
    </form>

    <% @shouts.each do |shout| %>
    <pre><%=h shout.created_at.strftime("%Y-%m-%d %H:%M:%S UTC") %><br/><%=h shout.message %></pre>
    <% end %>

    <!--div style="position: fixed; bottom: 2px; right: 20px;"-->
    <img src="http://code.google.com/appengine/images/appengine-noborder-120x30.gif" alt="Powered by Google App Engine" />
    <!--/div-->
  </body>
</html>