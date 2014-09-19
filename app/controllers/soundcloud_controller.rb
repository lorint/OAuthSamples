require 'soundcloud'

class SoundcloudController < ApplicationController
		def sc1
		# Starting the authentication from scratch here...
		session.delete(:sc_access_token)
		# Now that there's no trace left, go get the client and set the sc_access_token
		set_sc_client

#		raise @client.get("/me").inspect

		# redirect user to authorize URL
		# (will come back to http://localhost:3000/soundcloud)
		redirect_to @client.authorize_url()
	end

	def soundcloud
		set_sc_client

		# Find all the playlists
		@playlists = @client.get("/me/playlists")
		if @playlists.count == 0
			# No playlist?  Let's build one for them!
			@playlists = @client.post('/playlists', :playlist => {
			  title: 'My first dorky playlist',
			  sharing: 'public'
			})
			# And get an array of this one back
			@playlists = @client.get("/me/playlists")
		end

		# Find all the favorited tracks
		@favorites = @client.get("/me/favorites")
	end

	# Soundcloud authentication
	def set_sc_client
		if session[:sc_access_token]
			@client = SoundCloud.new(access_token: session[:sc_access_token])
		elsif params[:code]
			# Get the access token -- sample:
			#<SoundCloud::HashResponseWrapper access_token="1-85347-100761451-723189a958a52f" expires_in=21599 refresh_token="e326afe246cb88e66273528034adddf4" scope="*">
			get_client
			res = @client.exchange_token(code: params[:code])
			session[:sc_access_token] = res.access_token
		else
			get_client
		end
	end
	# Get a soundcloud client
	def get_client
		# create client object with app credentials
		@client = Soundcloud.new(:client_id => ENV['SC_CLIENT_ID'],
          :client_secret => ENV['SC_CLIENT_SECRET'],
          :redirect_uri => 'http://localhost:3000/soundcloud')
	end
end
