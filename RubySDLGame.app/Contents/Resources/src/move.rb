require 'mygame/boot'

x = y = 100
v = 5
main_loop do
  if key_pressed?(Key::UP)
    y = y - v
  end
  if key_pressed?(Key::DOWN)
    y = y + v
  end
  if key_pressed?(Key::RIGHT)
    x = x + v
  end
  if key_pressed?(Key::LEFT)
    x = x - v
  end
  FillSquare.render(100, 100, 300, 200, :color => [255, 255, 255])
  TransparentImage.render "icon.bmp", :x => x, :y => y
end
