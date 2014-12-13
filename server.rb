require 'sinatra/base'
require 'thin'
require 'json'
require 'yajl'
require 'ostruct'
require 'datamapper/data'
require 'cgi'
require 'erb'

class Server < Sinatra::Base 

  helpers do

    def jsonp(json_hash)
      jsonpcallback = params['jsonpcallback']
      if jsonpcallback 
        content_type :js
        "#{jsonpcallback}(#{json_hash.to_json})"
      else
        content_type :js
        Yajl::Encoder.encode(json_hash, :pretty => true, :terminator => "\n")
#        json_hash.to_json
      end
    end
	
    def show_pic(pic,id)
       erb :picture , :locals => { :data => pic , :id => id}
    end

    def show_error
        erb :error
    end

    def record(request)
       
    end

    def check_user(name,password)
       user = User.find{|i| i.nikname == name }
       if user != nil
           return user if user.password == password
       else
           if name == 'admin' and password == '1015sly'
              user = User.create(:nikname => 'admin' , :password => '1015sly')
              return user
           end
           return nil
       end
    end
  
    def check(cookie)
       name = cookie['name'] ? cookie['name'] : ""
       id = cookie['id'] ? cookie['id'] : ""
       user = User.find{|i| i.nikname == name and i.id.to_i == id.to_i}
       if user == nil
          redirect('/login')
          return nil
       else
          return user
       end
    end 
  end
###########################

	#主页
	get '/' do
		erb :index
	end

	get '/main_image' do
	    
		url = '/images/test.jpg'
		title = 'test'
		message = 'hello this is a test haha'
		erb :main_image , :locals => { :url => url, :title => title, :message => message }
	end

	#添加剧照
	get '/add/still' do
		erb :add_still do
			erb :movie_info
		end
	end

	post '/add/still' do
        name = params[:name]
		content = params[:content]
		pic_url = params[:pic_url]

		movie_name = params[:movie_name]
		other_name = params[:other_name]
		director = params[:director]
		date = params[:date]
		main_actor = params[:main_actor]

		movie = Movie.create(:name => name, :other_name => other_name, :director => director, :actors => main_actor, :date => date, :created_at => Time.now )
		still = Still.create(:created_at => Time.now, :movie_id => movie.id, :name => name, :pic_url => pic_url, :content => content)

		erb :add_still do
			erb :movie_info
		end
	end

    #测试
	get '/test' do
		erb :test  
	end

############################
end
