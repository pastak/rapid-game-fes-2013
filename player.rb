class Player

	SPEED = 10
	attr_reader:x,:y,:img,:dead
	def initialize(x,y,hp)
		@x = x
		@y = y
		@hp = hp
		@img = TransparentImage.new('icon.bmp')
		@time = 0
		@dead = false
	end
	
	def Update
		move
		collide
		shot if key_pressed?(Key::Z)
	end
	
	def crash
		@dead = true
	end
		
	def render
		@img.x = @x
		@img.y = @y
		@img.render
	end

	def move
		@x += SPEED if key_pressed?(Key::RIGHT) 
		@x -= SPEED if key_pressed?(Key::LEFT)
		@y += SPEED if key_pressed?(Key::DOWN)
		@y -= SPEED if key_pressed?(Key::UP)

	end

	def collide
		@x = 0 if @x < 0
		@x = W_W - @img.w if @x > W_W - @img.w
		@y = 0 if @y < 0
		@y = W_H - @img.h if @y > W_H - @img.h
	end
	
	def shot
		@time +=1
		if @time % 4 == 0
			$shots << Shot.new(@x,@y)
			$shots << Shot.new(@x+10,@y)
		end
	end
end
