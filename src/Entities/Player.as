package Entities
{	
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Player extends Entity
	{
		[Embed(source = '../../assets/sprites/player_right.png')] private const sprPlayerRight:Class;
		[Embed(source = '../../assets/sprites/player_left.png')] private const sprPlayerLeft:Class;		
		public var sprSwordguyLeft:Spritemap = new Spritemap(sprPlayerLeft, 48, 32);
		public var sprSwordguyRigth:Spritemap = new Spritemap(sprPlayerRight, 48, 32);
		
		private var xspeed:Number = 0;
		private var yspeed:Number = 0;
		private var aspeed:Number = 0.2;
		private var gspeed:Number = 0.2;
		private var fspeed:Number = 0.4;
		private var mspeed:Number = 1;
		private var jspeed:Number = 3.6;
		
		public function Player() 
		{
			sprSwordguyRigth.add("stand", [0, 1, 2, 3, 4, 5], 20, true);
			sprSwordguyRigth.add("run", [6, 7, 8, 9, 10, 11], 20, true);
			
			sprSwordguyLeft.add("stand", [0, 1, 2, 3, 4, 5], 20, true);
			sprSwordguyLeft.add("run", [6, 7, 8, 9, 10, 11], 20, true);
			
			graphic = sprSwordguyLeft;
			setHitbox(48, 32);
			
			Input.define("right", Key.RIGHT, Key.D);
			Input.define("left", Key.LEFT, Key.A);
			Input.define("jump", Key.X, Key.UP);
		}		
	
		
		public override function update():void
		{		
			if (Input.check("right")) 
			{ 
				xspeed += aspeed; 			
			}
			if (Input.check("left")) 
			{ 
				xspeed -= aspeed;  
			}
			if (Input.check("jump") && collide("level", x, y + 1)) 
			{ 
				yspeed = - jspeed; 
			}
			
			for (var i:int = 0; i < Math.abs(xspeed); i += 1) 
			{
				if (!collide("level", x + FP.sign(xspeed), y)) 
				{ 
					x += FP.sign(xspeed); 
				} 
				else 
				{ 
					xspeed = 0; 
					break; 
				}
			}
			for (i = 0; i < Math.abs(yspeed); i += 1) 
			{
				if (!collide("level", x, y + FP.sign(yspeed))) 
				{
					y += FP.sign(yspeed); 
				} 
				else 
				{ 
					yspeed = 0; 
					break; 
				}
			}
            yspeed += gspeed;			
		}
		
		private function isFalling():Boolean
		{
			return (collide("level", x, y) == null);			
		}
	}
}