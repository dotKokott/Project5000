package  
{	
	import Entities.Collectables.CollectableItem;
	import Entities.EmitterEntity;
	import Entities.EmitterEntity;
	import GUI.HUD;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import utilities.Camera;
	
	import Entities.Player;
	import Level.Level;
		
	public class GameWorld extends World
	{		
		[Embed(source = "Level/TestLevel.oel", mimeType = "application/octet-stream")] private static const DEFAULT_MAP:Class;		
		private var player:Player;
		private var hud:HUD;
		
		public function GameWorld() 
		{
			
		}
		
		override public function begin():void
		{					
			add(new Level(DEFAULT_MAP));
			player = new Player();			
			add(player);
			
			hud = new HUD(player);
			add(hud);

			add(new CollectableItem(50, 530));
		}		
	
		override public function update():void 
		{			
			super.update();
			if (Input.check(Key.ESCAPE))
			{
				FP.world = new MainMenuWorld;				
			}			
			hud.updateHUD();
			Camera.followPlayer(player);
		}		
	}		
}