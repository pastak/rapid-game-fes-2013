class Enemymaker
	def Update
			                #初期x 初期y spx spy
		$enemies << Enemy.new(140,-20,0 ,2) if ($time - 1*60).abs < 1
		$enemies << Mikan.new(-20,150,10 ,0) if ($time - 3*60).abs < 1
		$enemies << Mikan.new(-20,150,10 ,0) if ($time - 3.4*60).abs < 1
		$enemies << Mikan.new(-20,150,10 ,0) if ($time - 3.3*60).abs < 1
		$enemies << Mikan.new(-20,150,10 ,0) if ($time - 2.6*60).abs < 1
		$enemies << Mikan.new(-20,150,10 ,0) if ($time - 2.8*60).abs < 1
		$enemies << Mikan.new(-20,150,10 ,0) if ($time - 3*60).abs < 1
		$enemies << Momo.new(W_W/2,-20,0 ,6) if ($time - 7*60).abs < 1
		$enemies << Durian.new(W_W/2,100,0 ,0) if ($time - 10*60).abs < 0.5
		$enemies << Banana.new(W_W/2,200,0 ,0) if ($time - 10.2*60).abs < 0.5
		$enemies << Banana.new(W_W/2,200,0 ,0) if ($time - 10.4*60).abs < 0.5
		$enemies << Banana.new(W_W/2,200,0 ,0) if ($time - 10.6*60).abs < 0.5
		$enemies << Banana.new(W_W/2,200,0 ,0) if ($time - 10.8*60).abs < 0.5
		$enemies << Banana.new(W_W/2,200,0 ,0) if ($time - 11*60).abs < 0.5
		$enemies << Banana.new(W_W/2,200,0 ,0) if ($time - 11.2*60).abs < 0.5
		$enemies << Banana.new(W_W/2,200,0 ,0) if ($time - 11.4*60).abs < 0.5
		$enemies << Banana.new(W_W/2,200,0 ,0) if ($time - 11.6*60).abs < 0.5
		$enemies << Banana.new(W_W/2,200,0 ,0) if ($time - 11.8*60).abs < 0.5
		$enemies << Banana.new(W_W/2,200,0 ,0) if ($time - 12*60).abs < 0.5
		
	end
end
