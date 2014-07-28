require 'unirest'
require 'pry-byebug'
 
 
module MakerBlog
  class Client
    def list_posts
      code = 200
      response = Unirest.get('http://makerblog.herokuapp.com/posts', headers: { "Accept" => "application/json" })
      posts = response.body
      posts.each do |post|
#       { "post" => {"name" => "Eric Cantor",
#                    "title" => "Attn: Pollster Department",
#                    "content" => "You're all fired!!!!" }} 
        puts "Name: #{post["name"]}\nTitle: #{post["title"]}\n#{post["content"]}\n\n"
      end
      puts "ERROR: RESPONSE CODE SHOULD BE #{code} Actual response: #{response.code}" if response.code != code
    end
 
    def show_post(id)
      code = 200
      url = "http://makerblog.herokuapp.com/posts/#{id}"
 
      response = Unirest.get(url, headers: { "Accept" => "application/json" })
      post = response.body
 
      puts "ERROR: RESPONSE CODE SHOULD BE #{response.code} Actual response: #{response.code}" if response.code != code
      puts "Name: #{post["name"]}\nTitle: #{post["title"]}\n#{post["content"]}\n\n"
    end
 
    def create_post(name, title, content)
      code = 201
      url = "http://makerblog.herokuapp.com/posts"
      payload = {post: { name: name, title: title, content: content}}
 
      response = Unirest.post(url, headers: { "Accept" => "application/json", 
                                              "Content-Type" => "application/json"},
                                   parameters: payload)
 
      post = response.body
      puts "ERROR: RESPONSE CODE SHOULD BE #{code} Actual response: #{response.code}" if response.code != code
      puts "ID: #{post["id"]}\nName: #{post["name"]}\nTitle: #{post["title"]}\nCreated at: #{post["created_at"]}\nUpdated at: #{post["updated_at"]}\n#{post["content"]}\n\n"
    end
 
    def edit_post(id, options = {})
      code = 200
      url = "http://makerblog.herokuapp.com/posts/#{id}"
 
      params = {}
      params[:name   ] = options[:name   ] unless options[:name   ].nil?
      params[:title  ] = options[:title  ] unless options[:title  ].nil?
      params[:content] = options[:content] unless options[:content].nil?
 
      response = Unirest.put(url, headers: { "Accept" => "application/json", 
                                             "Content-Type" => "application/json"},
                                   parameters: {post: params})
 
      post = response.body
      puts "ERROR: RESPONSE CODE SHOULD BE #{code} Actual response: #{response.code}" if response.code != code
      puts "ID: #{post["id"]}\nName: #{post["name"]}\nTitle: #{post["title"]}\nCreated at: #{post["created_at"]}\nUpdated at: #{post["updated_at"]}\n#{post["content"]}\n\n"
    end
 
 
    def delete_post(id)
      code = 204
      url = "http://makerblog.herokuapp.com/posts/#{id}"
 
      response = Unirest.delete(url, headers: { "Accept" => "application/json" })
 
      puts "ERROR: RESPONSE CODE SHOULD BE #{code} Actual response: #{response.code}" if response.code != code
      puts "CODE: #{response.code}"
    end
 
  end
end
 
 
client = MakerBlog::Client.new
client.list_posts
#client.show_post(19113)
#client.create_post("Eric Cantor", "Attn: Pollster Dept.", "You're all fired!!!")
#client.edit_post(19114,{content: "Just kidding, but seriously, do better"})
#client.delete_post(19114)