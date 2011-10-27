package  
{
	import Entities.Player;
	import net.flashpunk.World;
	import Level.Level;
	public class MyWorld extends World
	{	
		[Embed(source = "Level/TestLevel.oel", mimeType = "application/octet-stream")] private static const DEFAULT_MAP:Class;		
		public function MyWorld() 
		{
		}
		
		override public function begin():void 
		{
			add(new Player());
			add(new Level(DEFAULT_MAP));
			super.begin();
		}
	}
}