package com.sempaigames.gafplayer.header;

import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.zip.InflateImpl;
import openfl.Assets;
import openfl.utils.ByteArray;
import openfl.utils.Endian;

class HeaderParser {

	public static function parse (bytes : ByteArray) : { header : Header, body : ByteArray } {

		var header = new Header();

		bytes.endian = Endian.LITTLE_ENDIAN;
		var footprint = bytes.readUnsignedInt();
		var valid = (footprint == 0x00474146) || (footprint == 0x00474143);
		var compressed = (footprint == 0x00474143);

		header.majorVersion = bytes.readUnsignedByte();
		header.minorVersion = bytes.readUnsignedByte();

		var fileLength = bytes.readUnsignedInt();

		var headerEnd = new ByteArray();
		headerEnd.endian = Endian.LITTLE_ENDIAN;
		while (bytes.bytesAvailable>0) {
			headerEnd.writeByte(bytes.readByte());
		}
		if (compressed) {
			headerEnd.uncompress();
		}

		if (header.majorVersion>=4) {
			readHeaderEndV4(headerEnd, header);
		} else {
			throw "Implement";
		}

		return { header : header, body : headerEnd };

	}

	public static function readHeaderEndV4 (bytes : ByteArray, header : Header) {

		var scaleValuesCount = bytes.readUnsignedInt();
		header.scaleValues = [];
		while (scaleValuesCount>0) {
			header.scaleValues.push(bytes.readFloat());
			scaleValuesCount--;
		}

		var csfValuesCount = bytes.readUnsignedInt();
		header.csfValues = [];
		while (csfValuesCount>0) {
			header.csfValues.push(bytes.readFloat());
			csfValuesCount--;
		}

	}

	public static function loadFromFile (path : String) {
		var bytes = Assets.getBytes(path);
		return HeaderParser.parse(bytes);
	}

}
