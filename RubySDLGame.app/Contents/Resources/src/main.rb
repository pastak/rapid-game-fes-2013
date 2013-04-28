require 'mygame/boot'

# ������
DX = 6
WINDOW_WIDTH = 640
WINDOW_HEIGHT = 480
PLAYER_WIDTH = 32
PLAYER_HEIGHT = 32
GROUND_Y = 440

# ��¤�Τ����
Bomb = Struct.new(:x, :y, :dy, :out_of_window)
Player = Struct.new(:x, :y)

# �ץ쥤�䡼�ΰ�ư
def move_player(player)
  player.x += DX if key_pressed?(Key::RIGHT)
  player.x -= DX if key_pressed?(Key::LEFT)
  player.x = [0, player.x].max
  player.x = [WINDOW_WIDTH - PLAYER_WIDTH, player.x].min
end

# ���Ƥΰ�ư
def move_bomb(bomb)
  bomb.y += bomb.dy
  if bomb.y > WINDOW_HEIGHT
    bomb.out_of_window = true
  end
end

# ������Ƚ��(1����)
def detect_collision_1d(x1, w1, x2, w2)
  if x1 < x2
    return x1 + w1 > x2
  else
    return x2 + w2 > x1
  end
end
# ������Ƚ��
def detect_collision(player, bomb)
  d1 = detect_collision_1d(player.x, PLAYER_WIDTH,
                           bomb.x, 70)
  d2 = detect_collision_1d(player.y, PLAYER_HEIGHT,
                           bomb.y + 20, 70)
  return d1 && d2
end

def game_over(time)
  wait = 60
  main_loop do
    Font.render("GAME OVER", :x => 300, :y => 240)
    Font.render(time.to_s, :x => 310, :y => 280)
    wait -= 1
    if wait < 0
      exit(0)
    end
  end
end

# �ץ쥤�䡼�ν���
player = Player.new(320, GROUND_Y-PLAYER_WIDTH)
# �ץ쥤�䡼�����ν���
player_img = TransparentImage.new("noschar.png",
                                  :w => PLAYER_WIDTH,
                                  :h => PLAYER_HEIGHT)
# �طʤ϶����ˤ���
MyGame.background_color = [128, 128, 255]

# ����s�ν���
bombs = []

# �ե���Ȥν���
Font.default_ttf_path = "font.ttf"
font = Font.new("0", :x => 40, :y=> 20)

time_count = 0

main_loop do
  move_player(player)

  # ���ƤΥ���������
  if rand(20) == 0
    bombs.push(Bomb.new(rand(660)-20, -60, rand(4)+4, false))
  end
  # ���Ƥΰ�ư
  bombs.each do |bomb|
    move_bomb(bomb)
  end
  bombs.delete_if do |bomb|
    bomb.out_of_window
  end

  # �ץ쥤�䡼�����Ƥ�������Ƚ��
  bombs.each do |bomb|
    if detect_collision(player, bomb)
      # �⤷�����ä��ʤ�Х����४���С�
      game_over(time_count)
    end
  end
  
  time_count += 1
  # �ץ쥤�䡼������
  player_img.x = player.x
  player_img.y = player.y
  player_img.render

  # ���Ƥ�����
  bombs.each do |bomb|
    TransparentImage.render("bomb.bmp",
                            :x => bomb.x, :y => bomb.y)    
  end
  # ���̤�����
  FillSquare.render(0, GROUND_Y, WINDOW_WIDTH,
                    WINDOW_HEIGHT - GROUND_Y,
                    :color => [255, 50, 0])
  # �в���֤�����
  font.string = time_count.to_s
  font.render
end
