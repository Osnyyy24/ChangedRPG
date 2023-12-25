package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class LoadState extends FlxState
{
	var back:FlxText;
	var text:FlxText;

	var textBG:FlxSprite;

	override public function create()
	{
		back = new FlxText(20, 20, 0, "y", 24);
		back.setFormat(AssetPaths.PixArrows__ttf, 24, FlxColor.WHITE, LEFT);
		add(back);

		textBG = new FlxSprite(0, 150);
		textBG.loadGraphic(AssetPaths.TextBG__png);
		textBG.screenCenter(X);
		textBG.scale.set(3, 2);
		add(textBG);

		text = new FlxText(0, 0, 0, "Here will be the\n Load archives");
		text.screenCenter();
		add(text);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.mouse.x >= back.x && FlxG.mouse.x <= back.x + back.width && FlxG.mouse.y >= back.y && FlxG.mouse.y <= back.y + back.height)
		{
			back.text = "w";

			if (FlxG.mouse.justPressed)
			{
				FlxG.sound.play(AssetPaths.MenuMove__ogg, 1, false);
				FlxG.switchState(new MenuState());
			}
		}
		else
		{
			back.text = "y";
		}
	}
}
