package  
{	
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import Entities.Player;
	import Level.Level;
	
	public class MyWorld extends World
	{	
		[Embed(source = "Level/TestLevel.oel", mimeType = "application/octet-stream")] private static const DEFAULT_MAP:Class;				
		public function MyWorld() 
		{
		}
		
		override public function begin():void
		{
			add(new Level(DEFAULT_MAP));
			add(new Player());			
		}		
	}
}