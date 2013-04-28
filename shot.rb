class Shot
	
	SPEED = 10
	attr_reader:dead
	def initialize(x,y)
		@x = x
		@y = y
		@img = Image.new('shot.png')
		@dead = false
	end

	def Update
		move
		die
	end

	def render
		@img.x = @x
		@img.y = @y
		@img.render
	end
	
	def die
		@dead = true if @y < 0 || @y > W_H || @x + @img.w < 0 || @x > W_W
	end 

	def move
		@y -= SPEED
	end

	def hit(e)
		distance = Math::sqrt( ((@x + @img.w/2) - (e.x + e.img.w/2))**2 + ( (@y + @img.h/2) - (e.y + e.img.h/2) )**2 )
		if @img.w/2 + e.img.w/2 > distance
			e.crash
			@dead = true 
		end
	end
end

class Enemyshot < Shot
	def initialize(x,y,spx,spy,img)
		@x = x
		@y = y
		@spx = spx
		@spy = spy
		@img = Image.new("#{img}.png")
	end
		
	def move
		@x += @spx
		@y += @spy
	end
end
