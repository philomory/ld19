module LD19
  class Enemy < Chingu::GameObject
    include TerrainCollision
    traits :velocity, :timer, :collision_detection
    trait :bounding_box, :scale => 0.8
    
    def initialize(options ={})
      super
      self.color = options[:color] || Color::RED
      @health = options[:health] || 1
      @animation = Chingu::Animation.new(:file => "blob_16x16.png",:bounce => true)
      random_walk
      update
    end
    
    def random_walk
      self.velocity_y = self.velocity_x = 0
      @moving = nil
      case rand(8)
      when 0 
        @moving = :south
        self.velocity_y =  2
      when 1
        @moving = :north
        self.velocity_y = -2
      when 2
        @moving = :east
        self.velocity_x =  2
      when 3
        @moving = :west
        self.velocity_x = -2
      end
      after(250) {random_walk}
    end
    
    def hit_by(weapon)
      return if @invincible
      return if @hitby == weapon
      @invincible = true
      @hitby = weapon
      take_damage(1)
      return if dead?
      Sound["enemy_ouch.wav"].play
      old_color = self.color
      self.color = 0x44FFFFFF
      self.mode = :additive
      after(50) do
        @invincible = false
        self.color = old_color
        self.mode = :default
      end
    end
    
    def take_damage(amount)
      @health -= amount
      die if @health <= 0
    end
    
    def die
      @dead = true
      Sound["enemy_dies.wav"].play
      destroy!
    end
    
    def dead?
      @dead
    end
        
    def update
      @image = @animation.next
      if @moving and colliding_with_terrain?
        @x, @y = @previous_x, @previous_y
        @velocity_x = @velocity_y = 0
      end
    end
    
    
    
  end
end