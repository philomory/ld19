module LD19
  TerrainProperties = {
    :stone_wall => {
      :image_file => "stone_wall.png",
      :walkable   => false,
      :passes_projectiles => false
    },
    
    :dirt_floor => {
      :image_file => "dirt_floor.png",
      :walkable   => true,
      :passes_projectiles => true
    },
    
    :grass_floor => {
      :image_file => "grass_floor.png",
      :walkable   => true,
      :passes_projectiles => true
    },
    
    :empty_floor => {
      :walkable => true,
      :passes_projectiles => true
    },
    
    :out_of_bounds => {
      :walkable => false,
      :passes_projectiles => false
    }
  }
end