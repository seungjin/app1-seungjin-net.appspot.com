require 'sinatra'
require 'dm-core'

require 'module/model_classes.rb'

# Configure DataMapper to use the App Engine datastore 
DataMapper.setup(:default, "appengine://auto")

# Make sure our template can use <%=h
helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

get '/' do
  'appengine, jruby, sinatra work....'
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
  if params[:message].strip != "" then
    shout = Shout.create(:message => params[:message].strip)
  end
  redirect '/shout!'
end



get '/q' do
    "now is #{Time.now}"
end





__END__

@@ index
<html>
  <head>
    <title>Shout!</title>
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
    <META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
    <!-- Copyright (C) 2005, 2006, 2007, 2008, 2009, 2010 seungjin.net -->
    <!--link rel="alternate" type="application/rss+xml" href="/Journals/form=feed&amp;size=40" title="RSS Feed, seungjin.net" /-->
    <meta name="date" content="<%=h Time.now.strftime("%Y-%m-%d %H:%M:%S %Z") %>">
    <meta name="author" content="Kim, Seung-jin">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=yes" />
    <link href="/styles/shout.css" rel="stylesheet" type="text/css">
  </head>
  <body style="font-family: sans-serif;">
    <h1>Shout!</h1>
    <hr/>
    <form method=post style="padding-bottom:5px;">
      <textarea name="message" rows="3rm" style="width:80%; float:left; margin-left: 0px; margin-right: 5px;" ></textarea>
      <input type=submit value="Shout!" class="submit" style="float:none; margin-left: 5px;" />
    </form>
    <div id="shouts">
      <% @shouts.each do |shout| %>
      <pre><%=h shout.created_at.strftime("%Y-%m-%d %H:%M:%S UTC") %><br/><%=h shout.message %></pre>
    <% end %>
    </div>
    <hr/>
    <!--div style="position: fixed; bottom: 2px; right: 20px;"-->
    <img src="http://code.google.com/appengine/images/appengine-noborder-120x30.gif" alt="Powered by Google App Engine" />
    <!--/div-->
  </body>
</html>
