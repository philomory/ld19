module LD19
  
  class PressStart < Chingu::GameObject
    trait :timer
    
    def setup
      @x = $window.width / 2
      @y = $window.height / 2 + 75
      @animation = Chingu::Animation.new(:file => 'press_start_105x22.png')
      during(500) {
        @image = @animation[0]
      }.then { during(3500) {
        @image = @animation[1]
      }.then { during(2000) {
        @image = @animation[2]
      }.then { @image = @animation[3] }}
      }
    end
    
  end
  
  class TitleState < Chingu::GameState
    trait :timer
    
    def setup
      @title = Chingu::GameObject.create(:image => 'title_screen.png')
      @title.center = 0
      self.input = {[:enter, :return] => :start_game}
      @press_start = PressStart.create
      @song = Song["title_music.ogg"]
      @song.play(true)
    end
    
    def start_game
      switch_game_state(OverworldState.new(:latitude => 11, :longitude => 11))
    end
  end
end
    