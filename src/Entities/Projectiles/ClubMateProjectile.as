package Entities.Projectiles 
{	
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;	
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.*

	public class ClubMateProjectile extends Entity
	{
		[Embed(source = '../../../assets/sprites/bottle.png')] private const SPRITE_BOTTLE:Class;
		[Embed(source = '../../../assets/sprites/scherbe.png')] private const SPRITE_SHARDS:Class;
		
		protected var horizontalSpeed:Number = 0.0;
		protected var verticalSpeed:Number = -6;
		protected var horizontalAcceleration:Number = 6;
		protected var gravity:Number = 0.2;
		protected var maximalSpeed:Number = 3;
		protected var EXPLOSION_SIZE:uint = 10;
		
		
		private var bottleImage:Image;
		private var ExplosionEmitter:Emitter;
		private var shardsSpritemap:Spritemap;
		
		public function ClubMateProjectile(Parent:Entity,Direction:Number) 
		{
			bottleImage = new Image(SPRITE_BOTTLE);
			shardsSpritemap = new Spritemap(SPRITE_SHARDS, 16, 16);
			
			graphic = bottleImage;			
			setHitbox(bottleImage.width, bottleImage.height);
						
			x = Parent.x + 10;
			y = Parent.y;
			
			horizontalAcceleration *= Direction;
			
			ExplosionEmitter = new Emitter(SPRITE_SHARDS, 16, 16);
			ExplosionEmitter.newType("explode", [0,1,2,3,4,5,6]);
			ExplosionEmitter.setAlpha("explode", 1, 0);
			ExplosionEmitter.setMotion("explode",  0, 30, 0.5, 180, -40, -0.5, Ease.expoOut);			
			
			ExplosionEmitter.relative = false;
			graphic = new Graphiclist(bottleImage, ExplosionEmitter);
			
			type = "projectile";
		}
		
		override public function update():void
		{
			horizontalSpeed += horizontalAcceleration;
			
			for (var i:int = 0; i < Math.abs(horizontalSpeed); i += 1) 
			{
				if (!collide("level", x + FP.sign(horizontalSpeed), y)) 
				{ 
					x += FP.sign(horizontalSpeed); 
				} 
				else 
				{ 
					destroy();
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
					destroy();
				}
			}
			
			verticalSpeed += gravity;
			
			if (Math.abs(horizontalSpeed) > maximalSpeed) 
			{ 
				horizontalSpeed = FP.sign(horizontalSpeed) * maximalSpeed; 
			}
		}
		
		private function destroy():void
		{
			if (collidable)
			{
				this.collidable = false;
				bottleImage.visible = false;
				
				for (var i:uint = 0; i < EXPLOSION_SIZE; i++)
				{
					ExplosionEmitter.emit("explode", this.centerX, this.centerY);				
				}
				
				if (!collidable && ExplosionEmitter.particleCount == EXPLOSION_SIZE)
				{
					this.world.remove(this);	
				}						
			}	
		}
	}

}