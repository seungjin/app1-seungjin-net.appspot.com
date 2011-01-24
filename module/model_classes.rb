
# Create your model class
class Shout
  include DataMapper::Resource
  
  property :id, Serial
  property :message, Text
  property :created_at, DateTime, :default => Time.now
  property :updated_at, DateTime, :default => Time.now
end