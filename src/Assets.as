package
{
	import flash.display.BitmapData;
	
	public class Assets
	{
		[Embed(source='../assets/sprites/mock_ground.png')]
		public static const SPRITE_TILESET:Class;	
		
		
		static public function get particle():BitmapData
		{
			var data:BitmapData = new BitmapData(1, 1, false, 0xFF0000);
			return data;
		}
	}
	
 }