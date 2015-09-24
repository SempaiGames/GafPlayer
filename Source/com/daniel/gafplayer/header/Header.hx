package com.daniel.gafplayer.header;

class Header {

	public var majorVersion : Int;
	public var minorVersion : Int;
	//public var scaleValuesCount : Int;
	public var scaleValues : Array<Float>;
	//public var csfValuesCount : Int;
	public var csfValues : Array<Float>;

	public function new () {

	}

	public function toString () {
		var ret = "";
		ret += "Version: " + majorVersion + "." + minorVersion + "\n";
		ret += "Scales values: " + scaleValues + "\n";
		ret += "CSF values: " + csfValues + "\n";
		return ret;
	}

}
