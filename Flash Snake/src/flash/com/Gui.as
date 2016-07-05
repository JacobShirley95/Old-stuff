package com{
	import flash.display.*;
	import flash.events.*;
	import flash.media.Sound;
	public class Gui extends frame {
		public var return_frame_rate=0;
		private var main_logo:logo;
		private var easy:easy_btn;
		private var medium:medium_btn;
		private var hard:hard_btn;
		private var var_over:over;
		private var var_again:play_again;
		public function Gui(type) {
			this.x=Game.main_stage.stageWidth/2;
			this.y=Game.main_stage.stageHeight/2;
			Game.main_stage.addChild(this);
			switch (type) {
				case "main menu" :
					menu();
					break;
				case "end" :
					end();
					break;
			}
		}
		private function menu() {
			main_logo = new logo();
			main_logo.x=0;
			main_logo.y=-120;
			this.addChild(main_logo);

			easy = new easy_btn();
			easy.x=0;
			easy.y=120;
			this.addChild(easy);

			medium = new medium_btn();
			medium.x=0;
			medium.y=60;
			this.addChild(medium);

			hard = new hard_btn();
			hard.x=0;
			hard.y=0;
			this.addChild(hard);

			easy.addEventListener(MouseEvent.CLICK, set_easy);
			medium.addEventListener(MouseEvent.CLICK, set_medium);
			hard.addEventListener(MouseEvent.CLICK, set_hard);

			function set_easy(e: MouseEvent) {
				destroy();
				Game.score_inc_amount=30;
				return_frame_rate=15;
				Game.goto(2);
			}
			function set_medium(e: MouseEvent) {
				destroy();
				Game.score_inc_amount=50;
				return_frame_rate=17;
				Game.goto(2);
			}
			function set_hard(e: MouseEvent) {
				destroy();
				Game.score_inc_amount=70;
				return_frame_rate=24;
				Game.goto(2);
			}
		}
		private function end() {
			var_over = new over();
			var_over.x=0;
			var_over.y=-120;
			this.addChild(var_over);

			var_again = new play_again();
			var_again.x=0;
			var_again.y=60;
			this.addChild(var_again);

			var_again.addEventListener(MouseEvent.CLICK, go_back);
			function go_back(e:MouseEvent) {
				destroy();
				//Game.se_death.stop();
				Game.goto(1);
			}
		}
		public function destroy() {
			Game.main_stage.removeChild(this);
		}
	}
}