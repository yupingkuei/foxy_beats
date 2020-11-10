class VinylsController < ApplicationController

	def index
		@vinyls = Vinyl.all
	end
end
