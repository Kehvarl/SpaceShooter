class Star
  attr_accessor :x, :y, :z, :sh, :r, :c, :mc
  def initialize x=1280, mx = 0
    @x = rand(x) + mx
    @y = rand(720)
    @z = rand(127) + 1
    @sh = rand(12) + 4
    @r = rand(360)
    @c = rand(15)
    @mc = c
  end

  def calc
    @c -= 1
    if @c <= 0
      @x -= 1
      @c = @mc
    end
    if @x < 0
      @x = rand(4) + 1276
      @y = rand(720)
      @sh = rand(12) + 4
      @r = rand(360)
      @c = rand(15)
      @mc = @c
    end
  end

  def render
    {x: @x, y: @y, w: @sh, h: @sh, path: 'sprites/star.png', angle: @r}.sprite!
  end
end

class Starfield
  def initialize
    @stars = []
    0..128.each { @stars << Star.new() }
    @x = 0
    @vx = -0.1
  end

  def reverse
    @vx = -@vx
  end

  def tick
    @x += @vx
    # @stars.each { |s| s.calc() }
  end

  def render
    arr = []
    arr << [0, 0, 1280, 720, 0, 0, 0].solids
    stars = 0
    @stars.each do |s|
      s.x += (@vx * s.z)
      if s.x >= 0 and s.x <= 1280
        arr << s.render()
        stars += 1
      end
    end
    if stars < 128
      if @vx < 0
        1..(128 - stars).each {@stars << Star.new(1280, 1280)}
      else
        1..(128 - stars).each {@stars << Star.new(0, 0)}
      end
    end
    arr
  end
end