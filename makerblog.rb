require 'unirest'

module MakerBlog
  class Client
    def list_posts
    	code = 200
      response = Unirest.get('http://makerblog.herokuapp.com/posts',
        headers: { "Accept" => "application/json" })
      posts = response.body
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

      response = Unirest.get(url,
        headers: { "Accept" => "application/json" })
      post = response.body
      puts "Name: #{post["name"]}\nTitle: #{post["title"]}\nContent: #{post["content"]}\n\n"
	    if response.code != code
      	puts "SHOW POST ID #{id}: Error code: #{response.code}. Expected code: #{code}"
      end
    end

    def create_post(name, title, content)
      url = 'http://makerblog.herokuapp.com/posts'
      payload = {:post => {'name' => name, 'title' => title, 'content' => content}}
      code = 201

      response = Unirest.post(url,
        headers: { "Accept" => "application/json",
                   "Content-Type" => "application/json" },
        parameters: payload)
      post = response.body
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

      response = Unirest.put(url,
        parameters: { :post => params },
        headers: { "Accept" => "application/json",
                   "Content-Type" => "application/json" })

      post = response.body
      # you know the drill, convert the response and display the result nicely
      puts "ID: #{post["id"]}\nName: #{post["name"]}\nTitle: #{post["title"]}\nContent: #{post["content"]}\nCreated at: #{post["created_at"]}\nUpdated at: #{post["updated_at"]}\n\n"
      if response.code != code
      	puts "EDIT: Error code: #{response.code}. Expected code: #{code}"
      end
    end

    def delete_post(id)
      url = "http://makerblog.herokuapp.com/posts/#{id}"
      code = 204

      response = Unirest.delete(url,
        headers: { "Accept" => "application/json" })
      puts response.code
      if response.code != code
      	puts "DELETE: Error code: #{response.code}. Expected code: #{code}"
      end
    end

  end
end


client = MakerBlog::Client.new
# client.list_posts
client.show_post(19206)
client.create_post("Slim Thug", "Thuggin'", "H from the bottom of the map")
client.edit_post(19206, {:name => "Mom", :content => "Moms rule"})
client.delete_post(19247)


