package com{
	public final class Geom {
		public static function radians(d:Number):Number {
			return d*Math.PI/180;
		}
		public static function degrees(r:Number):Number {
			return r*180/Math.PI;
		}
		public static function distance(Obj1,Obj2) {
			var dx=Obj1.x-Obj2.x;
			var dy=Obj1.y-Obj2.y;
			return Math.sqrt(dx*dx+dy*dy);
		}
	}
}