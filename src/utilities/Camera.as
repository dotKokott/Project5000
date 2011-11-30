package utilities 
{
	import net.flashpunk.FP
	import Entities.Player

	public class Camera 
	{
		public static function followPlayer(player:Player):void 
		{
			FP.camera.y = player.y -  (FP.screen.height /1.5)
			FP.camera.x = player.x - (FP.screen.width/2)
		}		
	}
}
