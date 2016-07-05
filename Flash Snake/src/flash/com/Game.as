package com{
	import effects.*;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.media.Sound;
	public final class Game {
		public static var main_stage:Stage=null;
		public static var se_eat_food:Sound = null;
		public static var se_death:Sound = null;
		public static var stage_map:Map;
		public static var goto = null;
		public static var main_snake:SnakeInstance;
		public static var main_food:FoodInstance;
		public static var score:int=0;
		public static var score_inc_amount:int = 30;
		public static function lost() {
			var blank=stage_map.getTile(main_snake.snake_head_index()).isBlank;
			if (! blank) {
				return true;
			}
			if (main_snake.out) {
				return true;
			}
		}
		public static function inc_score() {
			score+=score_inc_amount;
		}
		public static function destroy_elements() {
			main_snake.destroy();
			main_food.destroy();
		}
	}
}