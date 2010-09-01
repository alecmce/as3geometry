package test 
{
	import com.alecmce.maths.geom.line.QuadraticBezier;
	import com.alecmce.ui.Placeholder;
	import com.alecmce.ui.util.ClickAndDrag;
	import com.gskinner.motion.easing.Quadratic;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;

	public class TestQuadraticBezier extends Sprite 
	{
		private static const RADIUS:int = 2;
		private static const PARTICLES:uint = 1000;
		private static const PPF:uint = 20;
		private static const COUNT:uint = 40;
		private static const VARIATIONS:uint = 40;
		private static const START_VARIATION:Number = 20;		private static const FINISH_VARIATION:Number = 20;		private static const CONTROL_VARIATION:Number = 40;
		private static const ORIGIN:Point = new Point();

		private var button:Placeholder;
				private var container:Bitmap;		private var containerData:BitmapData;
		private var start:Sprite;
		private var control:Sprite;
		private var finish:Sprite;
		
		private var data:BitmapData;
		
		private var quadratic:QuadraticBezier;
		
		private var positions:Vector.<Number>;
		private var cache:Vector.<Vector.<Point>>;
		
		private var head:ParticleVO;
		private var tail:ParticleVO;
		private var count:uint;
		private var blur:BlurFilter;
		private var glow:GlowFilter;
		private var fade:ColorMatrixFilter;

		public function TestQuadraticBezier()
		{
			positions = generatePositions(COUNT);
			
			addChild(button = new Placeholder(100,50,0x00FF00,"go!"));
			button.y = 350;
			button.addEventListener(MouseEvent.CLICK, onClick);
			
			addChild(container = new Bitmap(containerData = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0)));
			addChild(start = generateControl(0xFFEE00, onStartChanged));			addChild(control = generateControl(0xFF0000, onControlChanged));
			addChild(finish = generateControl(0x9900FF, onFinishChanged));
			
			quadratic = new QuadraticBezier(start.x, start.y, finish.x, finish.y, control.x, control.y);
			quadratic.changed.add(onQuadraticChanged);
			onQuadraticChanged();
			
			var sprite:Sprite = generateSprite(0x1E90FF, 0.1);
			data = new BitmapData(RADIUS * 2, RADIUS * 2, true, 0);
			data.draw(sprite, new Matrix(1,0,0,1,RADIUS,RADIUS));
			
			blur = new BlurFilter(5,5,1);
			glow = new GlowFilter(0xFFFFFF,0.2,1,1,2,1,true);
			fade = new ColorMatrixFilter([1,0,0,0,0, 0,1,0,0,0, 0,0,1,0,0, 0,0,0,0.9,0]);
			
			resetCache();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onClick(event:MouseEvent):void 
		{			resetCache();
			draw();
		}
		
		private function resetCache():void
		{
			cache = new Vector.<Vector.<Point>>(VARIATIONS, true);
			
			for (var i:int = 0; i < VARIATIONS; i++)
			{
				var alt:QuadraticBezier = quadratic.variation(Math.random() * START_VARIATION, Math.random() * FINISH_VARIATION, Math.random() * CONTROL_VARIATION);
				cache[i] = alt.cache(positions);
			}
		}

		private function onQuadraticChanged():void 
		{
			draw();
		}

		private function generatePositions(count:uint):Vector.<Number> 
		{
			var positions:Vector.<Number> = new Vector.<Number>();
			
			var ease:Function = Quadratic.easeOut;
			var p:Number = 0;
			var dP:Number = 1 / count;
			for (var i:int = 0; i < count; i++)
			{
				positions[i] = ease(p, 0, 0, 0);
				p += dP;
			}
			
			return positions;
		}

		private function onStartChanged(start:InteractiveObject):void 
		{
			quadratic.setStart(start.x, start.y);
		}
		private function onFinishChanged(finish:InteractiveObject):void 
		{
			quadratic.setFinish(finish.x, finish.y);
		}
		private function onControlChanged(control:InteractiveObject):void 
		{
			quadratic.setControl(control.x, control.y);
		}

		private function generateControl(color:uint, listener:Function = null):Sprite 
		{
			var sprite:Sprite = generateSprite(color);
			sprite.x = stage.stageWidth * Math.random();			sprite.y = stage.stageHeight * Math.random();
			
			if (listener != null)
			{
				var decorator:ClickAndDrag = new ClickAndDrag(sprite);
				decorator.changed.add(listener);
			}
			
			return sprite;
		}
		
		private function generateSprite(color:uint, alpha:Number = 1):Sprite
		{
			var sprite:Sprite = new Sprite();
			
			sprite.graphics.beginFill(color, alpha);
			sprite.graphics.drawCircle(0, 0, RADIUS);
			sprite.graphics.endFill();
			
			return sprite;
		}
		
		private function draw():void
		{
			graphics.clear();
			graphics.lineStyle(2, 0);
			graphics.moveTo(start.x, start.y);
			graphics.curveTo(control.x, control.y, finish.x, finish.y);
		}
		
		private function onEnterFrame(event:Event):void 
		{
//			containerData.applyFilter(containerData, containerData.rect, ORIGIN, glow);			containerData.applyFilter(containerData, containerData.rect, ORIGIN, blur);//			containerData.applyFilter(containerData, containerData.rect, ORIGIN, fade);			
			var vo:ParticleVO = head;
			while (vo)
			{
				if (vo.iterate(containerData))
				{
					if (vo == head)
						head = vo.next;
						
					if (vo == tail)
						tail = null;
						
					vo.slice();
					--count;
				}
				
				vo = vo.next;
			}
			
			var qty:uint = PPF;
			while (count < PARTICLES && qty--)
			{
				var index:uint = Math.random() * positions.length;
				var positions:Vector.<Point> = cache[index];
				vo = new ParticleVO(data, positions);
				
				++count;
				
				if (tail)
				{
					tail.append(vo);
					tail = vo;
				}
				else
					head = tail = vo;
			}
		}
		
	}
}
