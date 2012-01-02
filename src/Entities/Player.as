package Entities
{	
	import Entities.Collectables.CollectableItem;
	import Entities.Projectiles.ClubMateProjectile;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class Player extends Entity
	{
		[Embed(source = '../../assets/sprites/player_right.png')] private const sprPlayerRight:Class;
		[Embed(source = '../../assets/sprites/player_left.png')] private const sprPlayerLeft:Class;			
		
		public var leftSpritemap:Spritemap;
		public var rightSpritemap:Spritemap;
		
		public var Health:int = 100;
		public var Score:int = 0;
		
		protected var horizontalSpeed:Number = 0.0;
		protected var verticalSpeed:Number = 0.0;
		protected var horizontalAcceleration:Number = 3;
		protected var gravity:Number = 0.2;
		protected var floatSpeed:Number = 0.2;
		protected var maximalSpeed:Number = 3;
		protected var jumpSpeed:Number = 6;		
		protected var direction:Number = 1;
				
		private var attackTimeout:Number = 0.3;
		private var attackTimer:Number = 0;
		private var allowAttack:Boolean = false;
		
		
		public function Player()
		{			
			leftSpritemap = new Spritemap(sprPlayerLeft, 48, 32);
			rightSpritemap = new Spritemap(sprPlayerRight, 48, 32);
			
			leftSpritemap.add("stand", [0, 1, 2, 3, 4, 5], 20, true);
			leftSpritemap.add("run", [6, 7, 8, 9, 10, 11], 20, true);
			leftSpritemap.add("attack", [12, 13, 14, 15, 16, 17], 20, true);
			
			rightSpritemap.add("stand", [0, 1, 2, 3, 4, 5], 20, true);
			rightSpritemap.add("run", [6, 7, 8, 9, 10, 11], 20, true);
			rightSpritemap.add("attack", [12, 13, 14, 15, 16, 17], 20, true);
			
			graphic = rightSpritemap;
			
			setHitbox(48, 32);
			Input.define("right", Key.RIGHT, Key.D);
			Input.define("left", Key.LEFT, Key.A);
			Input.define("jump", Key.X, Key.UP);
			Input.define("attack", Key.SPACE);
		}		
		
		override public function update():void 
		{
			animate();
			if (Input.check("right"))
			{ 				
				horizontalSpeed += horizontalAcceleration;
				direction = 1;
				graphic = rightSpritemap;
			}
			if (Input.check("left")) 
			{ 				
				horizontalSpeed -= horizontalAcceleration;  
				direction = -1;
				graphic = leftSpritemap;
			}
			
			if (Input.check("jump") && collide("level", x, y + 1)) 
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
			
			if (!Input.check("left")  && !Input.check("right"))
			{
				horizontalSpeed -= FP.sign(horizontalSpeed) * floatSpeed;
				
				if (horizontalSpeed > 0)
				{
				this.world.add(new EmitterEntity(this.x +32, this.y+32,FP.sign(horizontalSpeed)));
				}
								
				if (horizontalSpeed < 0)
				{
				this.world.add(new EmitterEntity(this.x , this.y+32, FP.sign(horizontalSpeed)));
				}
				
				if (Math.abs(horizontalSpeed) <= 0.2) 
				{ 
					horizontalSpeed = 0; 
				}
			}
			
			if (Math.abs(horizontalSpeed) > maximalSpeed) 
			{ 
				horizontalSpeed = FP.sign(horizontalSpeed) * maximalSpeed; 
			}

			if (!Input.check("jump") && verticalSpeed < 0) 
			{
				verticalSpeed += gravity;
			}
	 		
			if (attackTimer >= attackTimeout)
			{
				allowAttack = true;				
				attackTimer = 0;
			}
			else
			{
				attackTimer += FP.elapsed;
			}
			
			if (Input.check("attack") && allowAttack)
			{				
				this.world.add(new ClubMateProjectile(this, direction));
				allowAttack = false;
			}
			
			
			
			var item:CollectableItem = collide("collectable", x, y) as CollectableItem;
			if (item)
			{
				this.world.remove(item);
				Score += 1;
			}
		}
		
		public function animate():void
		{
			if (Input.check("left") || Input.check("right"))
			{
				(graphic as Spritemap).play("run");				
			}
			else
			{
				if (!Input.check("attack"))
				{
					(graphic as Spritemap).play("stand");	
				}
				else
				{
					(graphic as Spritemap).play("attack");
				}
			}			
		}
		
	}
}