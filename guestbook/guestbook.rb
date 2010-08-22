require 'sinatra'
require 'dm-core'

# Configure DataMapper to use the App Engine datastore 
DataMapper.setup(:default, "appengine://auto")

# Create your model class
class Shout
  include DataMapper::Resource
  
  property :id, Serial
  property :message, Text
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

get '/shoutout!' do
  # Just list all the shouts
  @shouts = Shout.all.reverse
  erb :index
end

post '/shoutout!' do
  # Create a new shout and redirect back to the list.
  shout = Shout.create(:message => params[:message])
  redirect '/shoutout!'
end

__END__

@@ index
<html>
  <head>
    <title>Shoutout!</title>
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
    <META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
    <!-- Copyright (C) 2005, 2006, 2007, 2008, 2009, 2010 seungjin.net -->
    <!--link rel="alternate" type="application/rss+xml" href="/Journals/form=feed&amp;size=40" title="RSS Feed, seungjin.net" /-->
    <meta name="date" content=" ">
    <meta name="author" content="Kim, Seung-jin">
    <link href="/styles/update.css" rel="stylesheet" type="text/css">
  </head>
  <body style="font-family: sans-serif;">
    <h1>Shoutout!</h1>
    <hr/>
    <form method=post>
      <textarea name="message" rows="3" style="width:80%"></textarea>
      <input type=submit value=Shout>
    </form>

    <% @shouts.each do |shout| %>
    <p>+<pre><%=h shout.message %></pre></p>
    <% end %>

    <div style="position: fixed; bottom: 2px; right: 20px;">
    <img src="http://code.google.com/appengine/images/appengine-noborder-120x30.gif" alt="Powered by Google App Engine" />
    </div>
  </body>
</html>