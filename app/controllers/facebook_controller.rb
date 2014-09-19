class FacebookController < ApplicationController
  def facebook
 		# Find the access token -- this is one way but it doesn't work with all kinds of requests
		res = HTTParty.post("https://graph.facebook.com/oauth/access_token?client_id=#{ENV["FB_CLIENT_ID"]}&client_secret=#{ENV["FB_CLIENT_SECRET"]}&" +
			'grant_type=client_credentials')
		# Find the offset of the access token
		idx = res.parsed_response.index("access_token=")
		# Note that if we get here and idx is less than 0 then we're screwed
		redirect_to posts_path(acc_token: res.parsed_response[idx + 13 .. -1])
  end

  def posts
  	# Well, maybe we can get a long-lived token with this somehow...
  	acc_token = params[:acc_token]
	# res = HTTParty.post('https://graph.facebook.com/oauth/access_token?client_id=ENV["FB_CLIENT_ID"]&client_secret=ENV["FB_CLIENT_SECRET"]&' +
  # 	"grant_type=fb_exchange_token&fb_exchange_token=#{params[:acc_token]}")
  # 	raise params[:acc_token] + ", " + res.parsed_response

  	# Whatever we wanna get
		# raise URI.encode("https://graph.facebook.com/v2.0/me/feeds?access_token=#{acc_token}")
		res = HTTParty.get(URI.encode("https://graph.facebook.com/me/feed?access_token=#{acc_token}"))
		raise res.parsed_response.inspect
  end
end
