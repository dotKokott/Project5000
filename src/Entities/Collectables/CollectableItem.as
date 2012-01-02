package Entities.Collectables 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	public class CollectableItem extends Entity
	{
		private var offsetY:int;
		private var floatBound:int = 20;
		private var floatStrength:Number = 0.5;
		
		public function CollectableItem(posX:int,posY:int) 
		{
			graphic = Image.createCircle(5, 0xFFFFFF);
			offsetY = posY;
			x = posX;
			y = posY;
			setHitbox(5, 5);
			type = "collectable";
		}
		
		public override function update():void
		{				
			if (y == (offsetY + floatBound))
			{
				floatStrength *= -1;
				floatBound *= -1;
				
				offsetY = y;
			}			
			y += floatStrength;
			
			
		}
	}
}