package;


import com.daniel.gafplayer.Parser;
import openfl.display.Sprite;


class Main extends Sprite {


	public function new () {

		super ();
		Parser.loadFromFile("assets/vamp-as3.gaf");
		

	}


}
