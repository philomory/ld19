module LD19
  class Prop::HiddenCaveEntrance < Prop::CaveEntrance
    def build
      super
      destroy! unless $window.basic_player.has_all_keys?
    end
  end
end