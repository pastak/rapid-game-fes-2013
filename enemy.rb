class Enemy
	attr_reader:img,:dead,:x,:y
	def initialize(x,y,spx,spy)
		@x = x
		@y = y
		@spx = spx
		@spy = spy
		@img = TransparentImage.new('ringo.png')
		@dead = false
		@time = 0
	end

	def Update
		@time += 1
		move
		shot
	end
	def crash
		@dead = true
	end
	
	def move
		@x += @spx
		@y += @spy
	end
	
	def shot
		if @time % 4 == 0
			$enemyshots << Enemyshot.new(@x,@y,0,5,"durians")
		end
	end

	def render
		@img.x = @x 
		@img.y = @y
		@img.render

	end
end

class Momo < Enemy
	def initialize(x,y,spx,spy)
		@x = x
		@y = y
		@spx = spx
		@spy = spy
		@img = TransparentImage.new('momo.png')
		@time = 0
	end
	
	def move
		# 10までは進んで、ちょっと待って帰る
		if @time <= 10
			@y += @spy		
		elsif 10 < @time && @time <= 5*60
		
		else
			@y -= @spy
		end
	end
	
	def shot
		if @time % 8 == 0
			$enemyshots << Enemyshot.new(@x,@y,0,5,'momos')
			$enemyshots << Enemyshot.new(@x,@y,2,5,'momos')
			$enemyshots << Enemyshot.new(@x,@y,-2,5,'momos')
		end
	end
	
	end

class Mikan < Enemy
	def initialize(x,y,spx,spy)
		@x = x
		@y = y
		@spx = spx
		@spy = spy
		@img = TransparentImage.new('mikan.png')
		@time = 0
	end

	def shot
		
	if @time % 3 == 0
		$players.each{|p|
		sp = 4
		ang = Math.atan2(p.y - @y, p.x - @x)
		spx1 = Math.cos(ang + PI/4) * sp
		spy1 = Math.sin(ang + PI/4) * sp
		spx2 = Math.cos(ang + PI/6) * sp
		spy2 = Math.sin(ang + PI/6) * sp
		spx = Math.cos(ang) * sp
		spy = Math.sin(ang) * sp
		$enemyshots << Enemyshot.new(@x,@y,spx,spy,'mikans')
		$enemyshots << Enemyshot.new(@x,@y,spx1,spy1,'mikans')
		$enemyshots << Enemyshot.new(@x,@y,spx2,spy2,'mikans')
		}
	end
	end
end

class Durian < Enemy
	def initialize(x,y,spx,spy)
		@x = x
		@y = y
		@spx = spx
		@spy = spy
		@img = TransparentImage.new('durian.png')
		@time = 0
		@hp = 100
		@k = 0
	end
	def shot
		@k += 0.1
		if @time % 8 == 0
			spx = Math.cos(@k) * 2
			spy = Math.sin(@k) * 2
			spx2 = Math.cos(@k+PI/2) * 2
			spy2 = Math.sin(@k+PI/2) * 2
			spx3 = Math.cos(@k-PI/2) * 2
			spy3 = Math.sin(@k-PI/2) * 2
			$enemyshots<<Enemyshot.new(@x+@img.w/2,@y+@img.h/2,spx ,spy,'durians' )
			$enemyshots<<Enemyshot.new(@x+@img.w/2,@y+@img.h/2,spx2 ,spy2,'durians' )
			$enemyshots<<Enemyshot.new(@x+@img.w/2,@y+@img.h/2,spx3 ,spy3,'durians' )
			$enemyshots<<Enemyshot.new(@x+@img.w/2,@y+@img.h/2,-spx ,-spy ,'durians')
		end
	end
	def crash
		if @hp == 1 
			@dead = true
		else	
			@hp -= 1
		end
		
	end
end

class Banana < Enemy
	def initialize(x,y,spx,spy)
		@x = x
		@y = y
		@spx = spx
		@spy = spy
		@img = TransparentImage.new('banana.png')
		@time = 0
		@hp = 1000
		@i = 0
	end
	def move
		super
		@i -= 1
		sp = 4
		@spx = Math.cos(PI*@i/80) * sp
		@spy = Math.sin(PI*@i/80) * sp
	end
end
