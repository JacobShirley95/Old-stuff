package com{
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.events.Event;
	public class SnakeInstance extends snake_block {
		private var Blocks:Array = new Array();
		public var Blocks_Amount:int=0;
		private var path:Array = new Array();
		private var c:int=0;
		public var cur_dir:String = "left";
		public var out = null;
		public function SnakeInstance(sx, sy, start_blocks) {
			try {
				var centre=Game.stage_map.getCentreTile(Game.stage_map.getTileIndex(new Point(sx,sy)));
				this.x=centre.x;
				this.y=centre.y;
				Game.main_stage.addChild(this);
				Game.stage_map.setTile(Game.stage_map.getTileIndex(new Point(sx,sy)), "blank", false);
				for (var i = 0; i < start_blocks; i++) {
					addBlock();
				}
				path=snake_tiles();
				c=path.length;
			} catch (e) {
				trace("Error in SnakeInstance.");
			}
		}
		public function addBlock() {
			var d:Point = new Point();
			var tile:int = 0;
			try {
				tile = Game.stage_map.getTileIndex(new Point(path[c-Blocks.length].x, path[c-Blocks.length].y));
			} catch (e){
				tile=snake_head_index();
			}
			Blocks[Blocks_Amount]=new BlockInstance();
			Blocks[Blocks_Amount].x=Game.stage_map.getCentreTile(tile).x;
			Blocks[Blocks_Amount].y=Game.stage_map.getCentreTile(tile).y;
			Game.stage_map.setTile(Game.stage_map.getTileIndex(new Point(Blocks[Blocks_Amount].x,Blocks[Blocks_Amount].y)), "blank", false);
			Game.main_stage.addChild(Blocks[Blocks_Amount]);
			Blocks_Amount++;
		}
		private function snake_tiles() {
			var tempArr:Array = new Array();
			for (var i = 1; i <= Blocks_Amount; i++) {
				tempArr[i-1] = new Tile();
				tempArr[i-1].x=Blocks[Blocks_Amount-i].x;
				tempArr[i-1].y=Blocks[Blocks_Amount-i].y;
			}
			tempArr[Blocks_Amount] = new Tile();
			tempArr[Blocks_Amount].x=this.x;
			tempArr[Blocks_Amount].y=this.y;
			return tempArr;
		}
		public function snake_tile_indexs() {
			var tempArr:Array = new Array();
			tempArr[0]=snake_head_index();
			for (var i = 1; i <= Blocks_Amount; i++) {
				tempArr[i]=Game.stage_map.getTileIndex(new Point(Blocks[i-1].x,Blocks[i-1].y));
			}
			return tempArr;
		}
		public function snake_head_index() {
			return Game.stage_map.getTileIndex(new Point(this.x, this.y));
		}
		public function move(dir) {
			try {
				out = false;
				switch (dir) {
					case "left" :
						this.x=Game.stage_map.getCentreTile(snake_head_index()-Consts.jump).x;
						this.y=Game.stage_map.getCentreTile(snake_head_index()).y;
						break;
					case "right" :
						this.x=Game.stage_map.getCentreTile(snake_head_index()+Consts.jump).x;
						this.y=Game.stage_map.getCentreTile(snake_head_index()).y;
						break;
					case "up" :
						this.x=Game.stage_map.getCentreTile(snake_head_index()).x;
						this.y=Game.stage_map.getCentreTile(snake_head_index()-1).y;
						break;
					case "down" :
						this.x=Game.stage_map.getCentreTile(snake_head_index()).x;
						this.y=Game.stage_map.getCentreTile(snake_head_index()+1).y;
						break;
				}
				cur_dir = dir;
				path[c] = new Tile();
				path[c].x=this.x;
				path[c].y=this.y;
				for (var i:int = 0; i < Blocks.length; i++) {
					Blocks[i].x=path[c-(i+1)].x;
					Blocks[i].y=path[c-(i+1)].y;
					Game.stage_map.setTile(Game.stage_map.getTileIndex(new Point(path[c-(i+1)].x, path[c-(i+1)].y)),"blank",false);
				}
				if (Geom.distance(path[c], path[c-1]) > 20) {
					out = true;
					return;
				}
				Game.stage_map.setTile(Game.stage_map.getTileIndex(new Point(path[c-(Blocks.length+1)].x, path[c-(Blocks.length+1)].y)),"blank",true);
				c++;
			} catch (e) {
				trace("Error in SnakeInstance.move()");
				out = true;
			}
		}
		public function destroy() {
			for (var i = 0; i < Blocks.length; i++) {
				Blocks[i].destroy();
			}
			Game.main_stage.removeChild(this);
		}
	}
}
