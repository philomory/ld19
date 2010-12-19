module LD19
  WindowWidth = 512
  WindowHeight = 480
  
  XFactor = 2
  YFactor = 2
  
  MapTilesWide = 16
  MapTilesHigh = 11
  MapYOffset = 16 * 4
  
  TileWidth = 16
  TileHeight = 16
  
  PlayerStartX = (MapTilesWide / 2 * TileWidth) * XFactor
  PlayerStartY = (MapTilesHigh / 2 * TileHeight + MapYOffset) * YFactor
  
  PlayerXEntryWest = TileWidth * XFactor
  PlayerXEntryEast = WindowWidth - PlayerXEntryWest
  
  PlayerYEntrySouth = WindowHeight - (TileWidth * YFactor)
  PlayerYEntryNorth = (MapYOffset + TileHeight) * YFactor
end