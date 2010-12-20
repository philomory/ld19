
include Gosu
#require 'Constants'
#require 'OverworldState'
Image.autoload_dirs << "#{ROOT}/media/gfx"
Sound.autoload_dirs << "#{ROOT}/media/sfx"
Song.autoload_dirs  << "#{ROOT}/media/music"

module LD19
  class MainWindow < Chingu::Window
    attr_reader :basic_player
    def initialize
      super(WindowWidth,WindowHeight)
      self.input = {:escape => :exit}
      self.factor = 2
      
      retrofy rescue nil
      @basic_player = BasicPlayer.new
      push_game_state(TitleState)
    end

    def restart
      @basic_player = BasicPLayer.new
      @game_state_manager.clear
      push_game_state(TitleState)
    end

  end
end
