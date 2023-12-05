package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;

class Player extends FlxSprite
{
	static inline var SPEED:Float = 10;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
	}
}
