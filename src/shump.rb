# �饤�֥����ɤ߹���
require "mygame/boot"
include Math

# ��¤�Τ����
Player = Struct.new(:x, :y, :dx, :dy, :d, :v, :shot_wait)
Shot = Struct.new(:x, :y, :dx, :dy, :life)
Enemy = Struct.new(:x, :y, :dx, :dy, :life)

# �������Ϥ���٤��Ѵ�����ؿ�
# move_player����Ȥ���
def key2d(kx, ky)
  case [kx, ky]
  when [0, 0]
    return :slow
  when [1, 0]
    return 0*8
  when [1, 1]
    return 1*8
  when [0, 1]
    return 2*8
  when [-1, 1]
    return 3*8
  when [-1, 0]
    return 4*8
  when [-1, -1]
    return 5*8
  when [0, -1]
    return 6*8
  when [1, -1]
    return 7*8
  end
end

# �ץ쥤�䡼��1�ե졼����®�٤�
# ���ߤ�®�٤ȳ��٤���׻�����
# move_player����Ȥ���
def calc_player_velocity(dx, dy, d)
  new_dx = dx + cos(2*PI*d/64)*0.6
  new_dy = dy + sin(2*PI*d/64)*0.6
  if new_dx**2 + new_dy**2 > 40
    return dx, dy
  else
    return new_dx, new_dy
  end
end

# �ץ쥤�䡼���ư������
def move_player(player)
  # d: �� 0 �� 16 �� 32 �� 48 �� 64=0  
  kx = ky = 0
  kx = -1 if key_pressed?(Key::LEFT)
  kx = 1 if key_pressed?(Key::RIGHT)
  ky = -1 if key_pressed?(Key::UP)
  ky = 1 if key_pressed?(Key::DOWN)

  # �������Ϥ���٤��Ѵ�����
  kd = key2d(kx, ky)

  if kd == :slow
    # �����ܡ��ɤ򲡤��Ƥ��ʤ����ϲ��⤷�ʤ�
  else
    # ���ϳ��٤��鼡�ե졼��μ����θ��������
    dd = (player.d - kd) % 64
    if dd == 0
    elsif dd >= 32
      player.d += 2
    else
      player.d -= 2
    end
    
    player.d %= 64
    player.dx, player.dy =
      calc_player_velocity(player.dx, player.dy, player.d)
  end

  # �໤�ˤ�긺®
  player.dx -= player.dx*0.1
  player.dy -= player.dy*0.1

  # ������ư����
  player.x += player.dx
  player.y += player.dy

  # ���̳��˽Фʤ��褦�ˤ���
  player.x = [player.x, 0].max
  player.x = [player.x, 640].min
  player.y = [player.y, 0].max
  player.y = [player.y, 480].min
end

# �ץ쥤�䡼���饷��åȤ���
def new_shot(player)
  d = player.d
  dx = cos(2*PI*d/64)*6 + player.dx
  dy = sin(2*PI*d/64)*6 + player.dy
  return Shot.new(player.x, player.y, dx, dy, 32)
end

# ����åȤ�1�ե졼��ư����
def move_shot(shot)
  shot.x += shot.dx
  shot.y += shot.dy
  shot.life -= 1
end

# Ũ����ư����
def move_enemy(enemy)
  enemy.x += enemy.dx
  enemy.y += enemy.dy
  # Ũ�������̤���Ф���Ũ���Ͼä�
  if enemy.x < -12 || enemy.x > 640+12 || enemy.y < -12 || enemy.y > 480+12
    enemy.life = 0
  end
end

# ��������⤿�줿����åȤ����褹��
def draw_shot(shot)
  screen.draw_circle(shot.x, shot.y, 4, [255, 255, 255])
end

# �ץ쥤�䡼�����褹��
def draw_player(player)
  screen.draw_circle(player.x, player.y, 16, [255,255,255])
  screen.draw_line(player.x, player.y,
                   player.x+Integer(cos(2*PI*player.d/64)*16),
                   player.y+Integer(sin(2*PI*player.d/64)*16),
                   [255,255,255])
end

# Ũ�����褹��
def draw_enemy(enemy)
  screen.draw_circle(enemy.x, enemy.y, 12, [255, 0, 0])
end

# ������Ũ����������
def new_enemy
  # 0: ���̺�����и�
  # 1: ���̱�����и�
  # 2: ���̾夫��и�
  # 3: ���̲�����и�
  case rand(3)
  when 0
    return Enemy.new(-12, rand(480), rand(2)+2, rand(5)-2, 1)
  when 1
    return Enemy.new(640+12, rand(480), -(rand(2)+2), rand(5)-2,1)
  when 2
    return Enemy.new(rand(640), -12, rand(5)-2, rand(2)+2,1)
  when 3
    return Enemy.new(rand(640), 480+12, rand(5)-2, -(rand(2)+2),1)
  end
end

# �����ॹ��������
player = Player.new(320, 240, 0, 0, 0, 0, 0)
shots = []
enemies = []

# �ᥤ��롼��
main_loop do
  move_player(player)

  # ����åȤ���������
  # shot_wait ��Ϣ��®�٤�Ĵ���Τ����
  # ���Ѥ���
  if key_pressed?(Key::Z) && player.shot_wait <= 0
    shots.push(new_shot(player)) #
    player.shot_wait = 6
  else
    player.shot_wait -= 1 if player.shot_wait > 0
  end

  # �������Ũ������������
  if rand(4) == 0
    enemies.push(new_enemy())
  end

  # Ũ��1�ĤŤ�ư����
  enemies.each do |enemy|
    move_enemy(enemy)
  end

  # ����åȤ�1�ĤŤ�ư����
  shots.each do |shot|
    move_shot(shot)
  end

  # Ũ���ȥ���åȤ�������Ƚ��򤹤�
  shots.each do |shot|
    enemies.each do |enemy|
      xd = shot.x - enemy.x
      yd = shot.y - enemy.y
      if sqrt(xd**2 + yd**2) <= 16 then
        shot.life = 0
        enemy.life -= 1
      end
    end
  end

  # �ä���٤�����åȤ����Ũ������Ǥ�����
  shots.delete_if do |shot|
    shot.life <= 0 
  end
  enemies.delete_if do |enemy|
    enemy.life <= 0
  end

  # �ʲ�����
  draw_player(player)
  shots.each do |shot|
    draw_shot(shot)
  end
  enemies.each do |enemy|
    draw_enemy(enemy)
  end
end
