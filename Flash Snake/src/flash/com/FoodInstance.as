package com{
	import flash.geom.Point;
	public class FoodInstance extends food_mc {
		public function FoodInstance(fx, fy) {
			try {
				var index=Game.stage_map.getTileIndex(new Point(fx,fy));
				var centre:Point=Game.stage_map.getCentreTile(index);
				this.x=centre.x;
				this.y=centre.y;
				Game.main_stage.addChild(this);
				Game.stage_map.setTile(index,"food",true);
			} catch (e) {
				trace("Error in FoodInstance.");
			}
		}
		public function set_r_pos() {
			for (var i = 0; i < 50; i++) {
				for (var ii = 0; ii < Game.main_snake.snake_tile_indexs().length; ii++) {
					var r_index=Math.round(Math.random()*Game.stage_map.tile_amount);
					if (r_index!=Game.main_snake.snake_tile_indexs()[ii]) {
						var centre=Game.stage_map.getCentreTile(r_index);
						this.x=centre.x;
						this.y=centre.y;
						Game.stage_map.setTile(Game.main_snake.snake_head_index(),"food", false);
		                Game.stage_map.setTile(r_index,"food", true);
						return;
					}
				}
			}
		}
		public function destroy() {
			Game.main_stage.removeChild(this);
		}
	}
}