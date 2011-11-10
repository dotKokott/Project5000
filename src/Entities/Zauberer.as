package Entities 
{
	import flash.events.WeakFunctionClosure;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Zauberer extends Entity
	{								
		protected var horizontalSpeed:Number = 0.0;
		protected var verticalSpeed:Number = 0.0;
		protected var horizontalAcceleration:Number = 3;
		protected var gravity:Number = 0.2;
		protected var floatSpeed:Number = 0.4;
		protected var maximalSpeed:Number = 3;
		protected var jumpSpeed:Number = 6;
		
		[Embed(source = '../../assets/sprites/zauberer_rechts.png')] private const sprPlayerRight:Class;
		private var ZaubererRechts:Image = new Image(sprPlayerRight);
		
		[Embed(source = '../../assets/sprites/zauberer_links.png')] private const sprPlayerLeft:Class;	
		private var ZaubererLinks:Image = new Image(sprPlayerLeft);
		
		public function Zauberer():void
		{
			ZaubererLinks.scale = 0.5;
			ZaubererRechts.scale = 0.5;
			graphic = ZaubererLinks;
			
			y = 200;
			x = 200;
			
			setHitbox(231 * ZaubererLinks.scale, 320 *ZaubererLinks.scale);
			
			Input.define("right_zauberer", Key.NUMPAD_6);
			Input.define("left_zauberer", Key.NUMPAD_4);
			Input.define("jump_zauberer", Key.NUMPAD_8);
		}
		
		override public function update():void 
		{
			if (Input.check("right_zauberer")) 
			{ 				
				horizontalSpeed += horizontalAcceleration;
				graphic = ZaubererRechts;
			}
			if (Input.check("left_zauberer")) 
			{ 				
				horizontalSpeed -= horizontalAcceleration;  
				graphic = ZaubererLinks;
			}
			
			if ((Input.check("jump_zauberer")) && collide("level", x, y + 1)) 
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
			
			if (!(Input.check("left_zauberer"))  && !(Input.check("right_zauberer"))) 
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

			if (!(Input.check("jump_zauberer")) && verticalSpeed < 0) 
			{
				verticalSpeed += gravity;
			}
		}				
	}

}