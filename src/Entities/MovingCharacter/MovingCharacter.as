package Entities.MovingCharacter 
{	
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	public class MovingCharacter extends Entity
	{						
		public var leftSpritemap:Spritemap;
		public var rightSpritemap:Spritemap;
		
		protected var horizontalSpeed:Number = 0.0;
		protected var verticalSpeed:Number = 0.0;
		protected var horizontalAcceleration:Number = 3;
		protected var gravity:Number = 0.2;
		protected var floatSpeed:Number = 0.4;
		protected var maximalSpeed:Number = 3;
		protected var jumpSpeed:Number = 6;
		
		override public function update():void 
		{
			if (getCharacterDirection() == CharacterDirection.RIGHT) 
			{ 				
				horizontalSpeed += horizontalAcceleration;
				graphic = rightSpritemap;
				rightSpritemap.play("run");
			}
			if (getCharacterDirection() == CharacterDirection.LEFT) 
			{ 				
				horizontalSpeed -= horizontalAcceleration;  
				graphic = leftSpritemap;
				leftSpritemap.play("run");
			}
			
			if ((getCharacterDirection() == CharacterDirection.JUMP) && collide("level", x, y + 1)) 
			{ 
				verticalSpeed = - jumpSpeed; 
			}
			
			for (var i:int = 0; i < Math.abs(horizontalSpeed); i += 1) 
			{
				if (!collide("level", x + FP.sign(horizontalSpeed), y)) 
				{ 
					x += FP.sign(horizontalSpeed); 
				} 
				else 
				{ 
					horizontalSpeed = 0; break; 
				}
			}
			
			for (i = 0; i < Math.abs(verticalSpeed); i += 1) 
			{
				if (!collide("level", x, y + FP.sign(verticalSpeed))) 
				{ 
					y += FP.sign(verticalSpeed); 
				} 
				else 
				{ 
					verticalSpeed = 0; break;
				}
			}
			
			verticalSpeed += gravity;
			
			if (!(getCharacterDirection() == CharacterDirection.LEFT)  && !(getCharacterDirection() == CharacterDirection.RIGHT)) 
			{
				horizontalSpeed -= FP.sign(horizontalSpeed) * floatSpeed;
				if (Math.abs(horizontalSpeed) <= 0.2) 
				{ 
					horizontalSpeed = 0; 
				}
			}
			
			if (Math.abs(horizontalSpeed) > maximalSpeed) 
			{ 
				horizontalSpeed = FP.sign(horizontalSpeed) * maximalSpeed; 
			}

			if (!(getCharacterDirection() == CharacterDirection.JUMP) && verticalSpeed < 0) 
			{
				verticalSpeed += gravity;
			}
			
			if (horizontalSpeed == 0)
			{
				rightSpritemap.play("stand");
				leftSpritemap.play("stand");				
			}
		}
				
		public function getCharacterDirection():int
		{
			return CharacterDirection.NONE;			
		}
	}
} 