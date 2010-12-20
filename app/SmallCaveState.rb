module LD19
  class SmallCaveState < RoomBaseState
    trait :timer
    def initialize(options ={})
      @properties = options
      @font = Font[25]
      Song.current_song.stop
      super
      @player.x = $window.width / 2
      @player.y = $window.height

      process_message
      process_gift if @properties[:gift]
    end

    def draw
      super
      @line_index.times do |full_line|
        @font.draw(@lines[full_line], (2 * TileWidth * XFactor), (((2 + full_line) * TileWidth + MapYOffset) * YFactor),1)
      end
      return unless @lines[@line_index]
      @font.draw(@lines[@line_index][0..@char_index],(2 * TileWidth * XFactor), (((2 + @line_index) * TileWidth + MapYOffset) * YFactor),1)
    end

    def transition(direction)
      pop_game_state
    end

    private

    def process_gift
      details = @properties[:gift]
      details[:x] = 7.5
      details[:y] = 6
      Prop.place(details)
    end

    def process_message
      if @properties[:message]
        cave_text_width = $window.width - (4 * TileWidth * XFactor)
        word_array = @properties[:message].upcase.split(' ')
        @lines = [word_array.shift]
        word_array.each do |word|
          if @font.text_width("#{@lines[-1]} #{word}") < cave_text_width
            @lines[-1] << ' ' << word
          else
            @lines.push(word)
          end
        end

        @message_index = @line_index = @char_index = 0
        every(100, :name => :message_timer) do
          unless @stop_message_timer
            @message_index += 1
            if @message_index >= @properties[:message].length - 1
              stop_timer(:message_timer)
              @stop_message_timer = true
            else
              @char_index += 1
              if @char_index >= @lines[@line_index].length
                @char_index = 0
                @line_index += 1
              end
            end
          end
        end
      end
    end
    
    
    def load_room_data
      @yml = { 
        :mappings => {'0' => @properties[:base]},
        :default => :empty_floor
      }
      @yml[:data] = <<EOF
0000000000000000
0..............0
0..............0
0..............0
0...&......&...0
0..............0
0..............0
0..............0
0..............0
0..............0
000000....000000
EOF
    
    end
  end
end

__END__

:data: |
    0000000000000..0
    0...........0...
    0...........0...
    0..._____...0000
    0..._000_......0
    0..._0D0_......0
    0..._____......0
    0...............
    0...............
    0...............
    0000000000000000    
:mappings: {
    '0': :stone_wall,
    '_': :dirt_floor
}
:default: :grass_floor
:props:
    - 
        :x: 6
        :y: 5
        :klass: CaveEntrance
        :properties: {
            :type: :small_cave,
            :base: :stone_wall,
            :message: "It is dangerous to go alone. Take this.",
            :occupant: :old_man,
            :gift: :talking_pie,
            :only_once: true
        }
