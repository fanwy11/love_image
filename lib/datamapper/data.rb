require 'rubygems'
require 'data_mapper' 

#DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'mysql://fanwy11:mysql@localhost/love_movie')


class Movie
  include DataMapper::Resource
	
  property :id,			Serial,         :key => true
  property :name,		String
  property :other_name,	String
  property :director,	String
  property :actors,     String
  property :date,		DateTime
  property :created_at,	DateTime
end

class Still
  include DataMapper::Resource

  property :id,         Serial,       :key => true
  property :created_at, DateTime
  property :movie_id,	Integer
  property :name,       String
  property :file_name,	String
  property :path,		String
  property :pic_url,    String	#图片来源
  property :content,	String
end

class Poster
	include DataMapper::Resource

	property :id,			Serial,		:key => true
	property :created_at,	DateTime
	property :movie_id,		Integer
	property :file_name,	String
	property :path,			String
	property :pic_url,		String
	property :content,		String
end

DataMapper.auto_upgrade!
