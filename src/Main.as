package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	[SWF(width="1024",height="768",frameRate="60")]
	public class Main extends Engine 
	{	
		public function Main()
		{
			super(1024, 768, 60, false);
			FP.world = new MyWorld;			
		}			
	}	
}