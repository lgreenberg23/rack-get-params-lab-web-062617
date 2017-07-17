require 'pry'
class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []
  
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    
    elsif req.path.match(/cart/)
      if @@cart.length >0
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      else
        resp.write "Your cart is empty"
      end

    elsif req.path.match(/add/)
      item = req.params["item"]  #I SEE THAT THIS IS COMING UP BLANK.. WHY?
      # binding.pry
      resp.write add_item(item)
    
    

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def add_item(item)
    if !@@items.include?(item) == true
        return "We don't have that item"
    else       
        @@cart << item
        return "added #{item}"
    end
  end


end



# INSTRUCTIONS
# Create a new class array called @@cart to hold any items in your cart
# Create a new route called /cart to show the items in your cart
# Create a new route called /add that takes in a GET param with the key item. 
# This should check to see if that item is in @@items and then add it to the cart if 
# it is.
# Otherwise give an error






