package Entities {
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Spritemap;
	
	public class EmitterEntity extends Entity {
		
		private var emitter:Emitter;
		private var timer:Number = 0;
		private var partical_count:int = 1;
		private var dustSpritemap:Spritemap
		[Embed(source = '../../assets/sprites/scherbe.png')] private const SPRITE_DUST:Class;
		//dustSpritemap = new Spritemap(SPRITE_DUST, 16, 16);
		
		public function EmitterEntity(PlayerPosX:int, PlayerPosY:int, direction:int)
		{
			emitter = new Emitter(SPRITE_DUST,16,16);
			
			emitter.newType('slide', [0]);
			emitter.setMotion('slide',0, 0, 0.2, 270, 20, 1); 
			this.graphic = emitter;
			slide(PlayerPosX, PlayerPosY);
		}
		
		
		
		private function slide(x:Number, y:Number):void {
			for (var i:int = 0; i < this.partical_count; i++) {
				emitter.emit('slide', x, y);
			}
		}
		
	}

}