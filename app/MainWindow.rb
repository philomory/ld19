require 'chingu'
require_relative 'helper'
include Gosu
#require 'Constants'
#require 'OverworldState'
Image.autoload_dirs << "#{ROOT}/media/gfx"
Sound.autoload_dirs << "#{ROOT}/media/sfx"
Song.autoload_dirs  << "#{ROOT}/media/music"

module LD19
  class MainWindow < Chingu::Window
    def initialize
      super(512,480)
      self.input = {:escape => :exit}
      self.factor = 2
      #retrofy
      push_game_state(OverworldState.new(:latitude => 11, :longitude => 11))
    end

  end
end
