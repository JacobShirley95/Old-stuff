package com {
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Point;
	public class Map {
		public var tile_amount:int=0;
		private var tiles:Array = new Array();
		private var c:int=0;
		public function Map() {
			try {
				for (var x = 0; x < Math.round(Consts.stage_width/Consts.main_tileWidth); x++) {
					for (var y = 0; y < Math.round(Consts.stage_height/Consts.main_tileHeight); y++) {
						tiles[c] = new Tile();
						tiles[c].x=(x*Consts.main_tileWidth)+1;
						tiles[c].y=(y*Consts.main_tileHeight)+1;
						tiles[c].x2=((x+1)*Consts.main_tileWidth)-1;
						tiles[c].y2=((y+1)*Consts.main_tileHeight)-1;
						tiles[c].isBlank=true;
						c++;
					}
				}
				tile_amount=c;
			} catch (e) {
				trace("Couldn't map the stage.");
			}
		}
		public function reset() {
			for (var i = 0; i < tile_amount; i++) setTile(i,"blank",true);
		}
		public function getTile(index) {
			return tiles[index];
		}
		public function getCentreTile(index) {
			try {
				var x = (getTile(index).x+getTile(index).x2)/2;
				var y = (getTile(index).y+getTile(index).y2)/2;
				return new Point(x, y);
			} catch (e) {
				trace("Couldn't get centre tile.");
			}
		}
		public function getCentreTilePoint(x,y) {
			try {
				return getCentreTile(getTileIndex(new Point(x, y)));
			} catch (e) {
				trace("Couldn't get the centre tile.");
			}
		}
		public function getTileIndex(p) {
			try {
				for (var i = 0; i < tile_amount; i++) {
					if (p.x>=getTile(i).x-1&&p.x<=getTile(i).x2+1&&p.y>=getTile(i).y-1&&p.y<=getTile(i).y2+1) {
						return i;
					}
				}
				return -1;
			} catch (e) {
				trace("Couldn't get the tile index.");
			}
		}
		public function setTile(index,style,bool) {
			try {
				switch (style) {
					case "food" :
						getTile(index).isFood=bool;
						break;
					case "blank" :
						getTile(index).isBlank=bool;
						break;
				}
			} catch (e) {
				trace("Couldn't set the tile to "+style+".");
			}
		}
	}
}