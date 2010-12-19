module LD19
  XFactor = 2
  YFactor = 2
  
  MapTilesWide = 16
  MapTilesHigh = 11
  MapYOffset = 16 * 4
  
  TileWidth = 16
  TileHeight = 16
  
  PlayerStartX = (MapTilesWide / 2 * TileWidth) * XFactor
  PlayerStartY = (MapTilesHigh / 2 * TileHeight + MapYOffset) * YFactor
end