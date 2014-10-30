class FacebookController < ApplicationController
  def log_out
  	res = HTTParty.delete('https://graph.facebook.com/v2.2/me/permissions?access_token='+ session[:fb_acc_token])
  	# OK so we logged out
  	session[:fb_acc_token] = nil
  	redirect_to root_path
  end

  def posts
  	# Awesome long access token
  	# Note that we can't have HTTParty parse the JSON coming back because
  	# occasionally an out-of-bounds character comes through and screws things up.
		res = HTTParty.get('https://graph.facebook.com/oauth/access_token?client_id=' + ENV["FB_CLIENT_ID"] + '&redirect_uri=http://localhost:3000/facebook/posts&client_secret=' + ENV["FB_CLIENT_SECRET"] +
			"&code=#{params["code"]}", {headers: {"Accept" => "application/json"}})
		idx = res.parsed_response.index("access_token=")
		# 13 is the length of "access_token:"
		acc_token = res.parsed_response[idx + 13 .. -1]
		# Trim off the "&expires=518400" crap at the end
		# (essentially it's good for 60 days)
		idx = acc_token.index("&")
		session[:fb_acc_token] = acc_token[0..idx - 1]

		# Now with this access token you can verify it if you need:
		# res = HTTParty.get('https://graph.facebook.com/debug_token?access_token='+ session[:fb_acc_token] +'&input_token=' + session[:fb_acc_token])

		# This so far has defaulted to having a scope of only the public profile

		# The "me" stuff refers to the logged-in user
		# https://graph.facebook.com/me/permissions&access_token=
		#res = HTTParty.get('https://graph.facebook.com/v2.2/me/permissions&access_token=' + acc_token)

		# # # Here's simply a user's name and ID
		# res = HTTParty.get('https://graph.facebook.com/v2.2/me?fields=id,name,link,gender,locale,age_range,email&access_token=' + session[:fb_acc_token], {format: :json})
		# # # This brings back something like:
		# # # {"id"=>"10152747337851668", "name"=>"Lorin Thwaits", "link"=>"https://www.facebook.com/app_scoped_user_id/10152747337851668/", "gender"=>"male", "locale"=>"en_US", "age_range"=>{"min"=>21}}
		# user_id = res.parsed_response["id"]
		# user_name = res.parsed_response["name"]
		# raise user_id + " " + user_name

		# # How about seeing who their friends are, or at least how many there are?
		res = HTTParty.get('https://graph.facebook.com/me/friends?access_token=' + session[:fb_acc_token], {format: :json})
		@friend_count = res.parsed_response["summary"]["total_count"]
  end
end
