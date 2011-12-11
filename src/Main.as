package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;

	[SWF(width="800",height="608",frameRate="60")]
	public class Main extends Engine 
	{	
		public function Main()
		{			
			super(800, 608, 60, false);
			FP.world = new MainMenuWorld;			
		}			
	}	
}