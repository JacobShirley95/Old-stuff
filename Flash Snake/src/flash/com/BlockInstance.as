package com{
	import flash.geom.Point;
	public class BlockInstance extends snake_block{
		public function curTile() {
			return Game.stage_map.getTileIndex(new Point(this.x, this.y));
		}
		public function destroy() {
			Game.main_stage.removeChild(this);
		}
	}
}