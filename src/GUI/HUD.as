package GUI 
{
	import net.flashpunk.FP;
	import Entities.Player;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Image;
	
	public class HUD extends Entity
	{
		private var player:Player;
		private var bar:Image;		
		
		public function HUD(player:Player) 
		{
			this.player = player;
			var frame:Image = Image.createRect(102, 20);
			frame.x = 4;
			frame.y = 4;
			frame.scrollX = 0;
			frame.scrollY = 0;
			
			var inside:Image = Image.createRect(100, 18, 0xFF000000);
			inside.scrollX = 0;
			inside.scrollY = 0;
			inside.x = 5;
			inside.y = 5;
			
			
			bar = Image.createRect(1, 18, 0xffff0000);
			bar.x = 5;
			bar.y = 5;
			bar.scrollX = 0;
			bar.scrollY = 0;
			bar.originX = 0;
			bar.originY = 0;
			
			bar.scaleX = 26;
			
			
			graphic = new Graphiclist(frame,inside, bar);
			updateHUD();
		}
		
		public function updateHUD():void
		{
			bar.scaleX = player.Health;
		}		
	}
}