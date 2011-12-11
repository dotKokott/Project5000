package  
{
	import flash.display.SimpleButton;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import GUI.Button;
	
	public class MainMenuWorld extends World
	{
		[Embed(source = '../assets/sprites/button_playgame.png')]
		private const PLAYBUTTONIMAGE:Class;
 
		private var playButton:Button;
		
		public function MainMenuWorld() 
		{
			playButton = new Button(playGame, null, (FP.screen.width / 2) - 156,FP.screen.height / 2);
			playButton.setSpritemap(PLAYBUTTONIMAGE, 312, 22);
			add(playButton);			
		}
		
		private function playGame():void
		{
			FP.world = new GameWorld();		 
			destroy();
		}
		 
		public function destroy():void
		{
			removeAll();		 
			playButton = null;
		}		
	}
}