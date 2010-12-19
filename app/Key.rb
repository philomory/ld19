module LD19
  class Prop::Key < Prop::Pickup
    attr_reader :number
    def build(properties = {})
      @number = properties[:number]
      destroy! if $window.basic_player.has_key?(@number)
      @number = @number.to_i
      @image = Image["key#{@number}.png"]
      @angle = 180
    end
    
    def picked_up_by(player)
      player.get_key(self)
    end
    
  end
end