package Level 
{
	import flash.utils.ByteArray;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	public class Level extends Entity
	{		
		private var _tiles:Tilemap;
		private var _grid:Grid;
		
		public function Level(xml:Class)
		{
			_tiles = new Tilemap(Assets.SPRITE_TILESET, 1024, 786, 16, 16);
			
			graphic = _tiles;
			layer = 1;
			
			_grid = new Grid(1024, 786, 16, 16, 0, 0);
			mask = _grid;
			type = "level";

			loadLevel(xml);
		}
		
		private function loadLevel(xml:Class):void
		{
			var rawData:ByteArray = new xml;
			var dataString:String = rawData.readUTFBytes(rawData.length);
			var xmlData:XML = new XML(dataString);
			
			var dataList:XMLList;
			var dataElement:XML;
			
			
			dataList = xmlData.OurTiles.tile;			
			for each(dataElement in dataList)
			{
				_tiles.setTile(int(dataElement.@x) / 16, int(dataElement.@y) / 16, int(dataElement.@tx) / 16);				
				_grid.setTile(int(dataElement.@x) / 16, int(dataElement.@y) / 16, (int(dataElement.@tx) / 16 == 0));
			}
			
		}
	}

}