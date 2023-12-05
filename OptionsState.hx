package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class OptionsState extends FlxState
{
	var title:FlxText;

	override public function create()
	{
		title = new FlxText(0, 100, 0, "This is the OptionsState", 24);
		title.setFormat(AssetPaths.Crang__ttf, 38, FlxColor.WHITE, CENTER);
		title.alignment = LEFT;
		title.screenCenter(X);
		add(title);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
