package Entities
{	
	import Entities.MovingCharacter.MovingCharacter;
	import Entities.MovingCharacter.CharacterDirection;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class Player extends MovingCharacter
	{
		[Embed(source = '../../assets/sprites/player_right.png')] private const sprPlayerRight:Class;
		[Embed(source = '../../assets/sprites/player_left.png')] private const sprPlayerLeft:Class;			
		
		public function Player()
		{			
			leftSpritemap = new Spritemap(sprPlayerLeft, 48, 32);
			rightSpritemap = new Spritemap(sprPlayerRight, 48, 32);
			
			leftSpritemap.add("stand", [0, 1, 2, 3, 4, 5], 20, true);
			leftSpritemap.add("run", [6, 7, 8, 9, 10, 11], 20, true);
			
			rightSpritemap.add("stand", [0, 1, 2, 3, 4, 5], 20, true);
			rightSpritemap.add("run", [6, 7, 8, 9, 10, 11], 20, true);
			
			graphic = rightSpritemap;
			
			setHitbox(48, 32);
			y = 500;
			Input.define("right", Key.RIGHT, Key.D);
			Input.define("left", Key.LEFT, Key.A);
			Input.define("jump", Key.X, Key.UP);
		}
		
		override public function getCharacterDirection():int
		{
			if (Input.check("right"))
			{
				return CharacterDirection.RIGHT;
			}
			if (Input.check("left"))
			{
				return CharacterDirection.LEFT
			}
			if (Input.check("jump"))
			{
				return CharacterDirection.JUMP;
			}
			return CharacterDirection.NONE;
		}		
	}
}