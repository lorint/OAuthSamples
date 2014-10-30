class SmugmugController < ApplicationController
	def index
		@albums = HTTParty.get("http://api.smugmug.com/services/api/json/1.3.0/?method=smugmug.albums.get&APIKey=G74NPxhieE70QY5IV2i9QYeGaoU2EyLe&SessionID=6d9a73c0e94275ae27a1cf6df0fade4b")
	end
end
