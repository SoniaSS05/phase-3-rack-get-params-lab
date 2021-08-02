class Application

  @@items = ["Apples","Carrots","Pears"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    @@all = []

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart!=[]
        @@cart.each do |itemcart|
          resp.write "#{itemcart}\n"
        end
      else
        resp.write "Your cart is empty"
      end
    elsif req.path.match(/add/)

      add_item_cart = req.params["item"]
      if @@items.include?(add_item_cart)
        @@cart << add_item_cart
        resp.write "added #{add_item_cart}"
      else
        resp.write "We don't have that item!"
      end

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
end
