class Background
	SPEED = 5
	def initialize(x,y)
		@x = x
		@y = y
		@img = Image.new('back1.png')
	end
	
	def move
		@y += SPEED	
	end

	def render
		@img.x = @x
		@img.y = @y
		@img.render
		@y = -W_H if @y == W_H
	end
end
