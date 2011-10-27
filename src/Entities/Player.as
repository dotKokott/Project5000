package Entities
{	
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Player extends Entity
	{
		[Embed(source = '../../assets/sprites/player_mock.png')] private const PLAYERSPRITE:Class;		
		public var sprSwordguy:Spritemap = new Spritemap(PLAYERSPRITE, 48, 32);
		
		public var speed:Number = 150;
		
		public function Player() 
		{
			sprSwordguy.add("stand", [0, 1, 2, 3, 4, 5], 20, true);
			sprSwordguy.add("run", [6, 7, 8, 9, 10, 11], 20, true);
			graphic = sprSwordguy;
		}		
	
		
		public override function update():void
		{
			
			if (Input.check(Key.D))
			{
				sprSwordguy.play("run", false);
				x += speed * FP.elapsed;				
			}
			else
			{
				sprSwordguy.play("stand");				
			}						
		}		
	}
}