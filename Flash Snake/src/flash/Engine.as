package {
	import com.*;
	import effects.*;
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.media.*;
	public class Engine extends MovieClip {
		private var dir="left";
		private var food=null;
		private var blank=null;
		private var Snake:SnakeInstance;
		private var Food:FoodInstance;
		private var gui:Gui;
		public function Engine() {
			Game.se_eat_food = new eat_food();
			Game.se_death = new death();
			Game.main_stage=stage;
			Game.goto=gotoAndStop;
			stop();
		}
		public function start_GUI(type) {
			gui=new Gui(type);
		}
		public function start() {
			start_GUI("game");
			addEventListener(Event.ENTER_FRAME, run);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, key_Down);
		}
		public function key_Down(e:KeyboardEvent) {
			switch (e.keyCode) {
				case 37 :
					dir="left";
					break;
				case 38 :
					dir="up";
					break;
				case 39 :
					dir="right";
					break;
				case 40 :
					dir="down";
					break;
			}
		}
		public function init() {
			stage.frameRate=gui.return_frame_rate;
			stage.focus=stage;

			Game.stage_map=new Map();
			Snake=new SnakeInstance(stage.stageWidth/2,stage.stageHeight/2,10);
			Game.main_snake=Snake;
			
			Food=new FoodInstance(200,200);
			Game.main_food=Food;
		}
		public function handle_lost() {
			Game.destroy_elements();
			removeEventListener(Event.ENTER_FRAME, run);
			start_GUI("end");
			Game.score=0;
		}
		private function run(e:Event) {
			if (Snake.cur_dir=="left"&&dir=="right") {
				dir="left";
			}
			if (Snake.cur_dir=="right"&&dir=="left") {
				dir="right";
			}
			if (Snake.cur_dir=="up"&&dir=="down") {
				dir="up";
			}
			if (Snake.cur_dir=="down"&&dir=="up") {
				dir="down";
			}
			Snake.move(dir);
			var food=Game.stage_map.getTile(Snake.snake_head_index()).isFood;
			if (food) {
				Game.se_eat_food.play();
				Food.set_r_pos();
				Snake.addBlock();
				Game.inc_score();
				score_txt.text="Score: "+Game.score;
			}
			if (Game.lost()) {
				Game.se_death.play();
				gotoAndStop(3);
			}
		}
	}
}