require 'rest_client'
require 'pry-byebug'
require 'json'

module MakerBlog
  class Client
    def list_posts
    	code = 200
      response = RestClient.get('http://makerblog.herokuapp.com/posts',
        :accept => :json )
      posts = JSON.parse(response.body)
      posts.each do |post|
        puts "Name: #{post["name"]}\nTitle: #{post["title"]}\nContent: #{post["content"]}\n\n"
      end
      if response.code != code
      	puts "LIST: Error code: #{response.code}. Expected code: #{code}"
      end
    end

    def show_post(id)
      # hint: URLs are strings and you'll need to append the ID
      url = "http://makerblog.herokuapp.com/posts/#{id}"
      code = 200

      response = RestClient.get(url, {:accept => :json })
      post = JSON.parse(response.body)
      puts "Name: #{post["name"]}\nTitle: #{post["title"]}\nContent: #{post["content"]}\n\n"
	    if response.code != code
      	puts "SHOW POST ID #{id}: Error code: #{response.code}. Expected code: #{code}"
      end
    end

    def create_post(name, title, content)
      url = 'http://makerblog.herokuapp.com/posts'
      payload = {:post => {:name => name, :title => title, :content => content}}
      code = 201

      response = RestClient.post(url, :parameters => payload,
        :accept => :json, :content_type => :json)
      post = JSON.parse(response.body)
      # convert then display your results here
      puts "ID: #{post["id"]}\nName: #{post["name"]}\nTitle: #{post["title"]}\nContent: #{post["content"]}\nCreated at: #{post["created_at"]}\nUpdated at: #{post["updated_at"]}\n\n"
			if response.code != code
      	puts "CREATE: Error code: #{response.code}. Expected code: #{code}"
      end
    end

    def edit_post(id, options = {})
      url = "http://makerblog.herokuapp.com/posts/#{id}"
      params = {}
      code = 200

      # can't figure this part out? Google "ruby options hash"
      params[:name] = options[:name] unless options[:name].nil?
      params[:title] = options[:title] unless options[:title].nil?
      params[:content] = options[:content] unless options[:content].nil?

      response = RestClient.put(url,
        { :post => params },
        { :accept => :json, :content_type => :json })

      post = JSON.parse(response.body)
      # you know the drill, convert the response and display the result nicely
      puts "ID: #{post["id"]}\nName: #{post["name"]}\nTitle: #{post["title"]}\nContent: #{post["content"]}\nCreated at: #{post["created_at"]}\nUpdated at: #{post["updated_at"]}\n\n"
      if response.code != code
      	puts "EDIT: Error code: #{response.code}. Expected code: #{code}"
      end
    end

    def delete_post(id)
      url = "http://makerblog.herokuapp.com/posts/#{id}"
      code = 204

      response = RestClient.delete(url, { :accept => :json })
      # JSON parse puts statement below won't work because 
      # 'response.body' is gone already???
      # puts JSON.parse(response.body)
      if response.code != code
      	puts "DELETE: Error code: #{response.code}. Expected code: #{code}"
      end
    end

  end
end


client = MakerBlog::Client.new
# client.list_posts
# client.show_post(19604)
client.create_post("Slim Thug", "Thuggin'", "H from the bottom of the map")
# client.edit_post(19604, {:name => "Mom", :content => "Moms rule"})
# client.delete_post(19618)


