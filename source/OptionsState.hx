package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.ui.FlxUICheckBox;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;
import lime.ui.Window;

class OptionsState extends FlxState
{
	var backgrounds:FlxSprite;

	var back:FlxText;
	var title:FlxText;

	var checkfs:FlxUICheckBox;

	var window:Window;

	var textBG:FlxSprite;

	var volumeTexts:Array<FlxText> = [];
	var volume:FlxText;
	var volumeButtons:Array<Dynamic> = [['-'], ['+']];

	override public function create()
	{
		backgrounds = new FlxSprite();
		backgrounds.loadGraphic(AssetPaths.Warehouse__png);
		backgrounds.screenCenter();
		add(backgrounds);

		back = new FlxText(20, 20, 0, "y", 24);
		back.setFormat(AssetPaths.PixArrows__ttf, 24, FlxColor.WHITE, LEFT);
		add(back);

		textBG = new FlxSprite(0, 150);
		textBG.loadGraphic(AssetPaths.TextBG__png);
		textBG.screenCenter(X);
		textBG.alpha = 0.7;
		textBG.scale.set(3, 2);
		add(textBG);

		title = new FlxText(30, 125, 0, "Volume", 24);
		title.setFormat(AssetPaths.CooperBits__ttf, 24, FlxColor.WHITE, CENTER);
		title.alignment = LEFT;
		add(title);
		title = new FlxText(170, 125, 0, "FullScreen?", 24);
		title.setFormat(AssetPaths.CooperBits__ttf, 24, FlxColor.WHITE, CENTER);
		title.alignment = LEFT;
		add(title);

		checkfs = new FlxUICheckBox(195, 160, null, null, "", 100);
		checkfs.callback = function()
		{
			if (checkfs.checked)
			{
				FlxG.fullscreen = !FlxG.fullscreen;
			}
			else
			{
				FlxG.fullscreen = !FlxG.fullscreen;
			}
		}
		add(checkfs);

		volume = new FlxText(70, 145, 0, "", 24);
		volume.setFormat(AssetPaths.CooperBits__ttf, 24, FlxColor.WHITE, CENTER);

		add(volume);

		for (i in 0...volumeButtons.length)
		{
			var volumeText = new FlxText(30 + (80 * i), 160, 0, volumeButtons[i][0], 24);
			volumeText.setFormat(AssetPaths.CooperBits__ttf, 24, FlxColor.WHITE, CENTER);
			add(volumeText);
			volumeTexts.push(volumeText);
		}

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.volume <= 0.1)
		{
			volume.text = "Min";
		}
		else
		{
			volume.text = Std.string(FlxG.sound.volume);
		}

		if (FlxG.sound.volume <= 1)
		{
			volume.x = 60;
		}

		if (FlxG.sound.volume > 0.9)
		{
			volume.x = 70;
		}

		for (i in 0...volumeButtons.length)
		{
			var volumeButton:FlxText = volumeTexts[i];

			if (FlxG.mouse.x >= volumeButton.x
				&& FlxG.mouse.x <= volumeButton.x + volumeButton.width
				&& FlxG.mouse.y >= volumeButton.y
				&& FlxG.mouse.y <= volumeButton.y + volumeButton.height)
			{
				volumeButton.borderStyle = FlxTextBorderStyle.OUTLINE;
				volumeButton.color = FlxColor.BLACK;
				volumeButton.borderColor = FlxColor.WHITE;

				if (FlxG.mouse.justPressed)
				{
					FlxG.sound.play(AssetPaths.MenuMove__ogg, 1, false);
					switch (volumeButtons[i][0])
					{
						case '-':
							FlxG.sound.volume -= 0.1;
						case '+':
							FlxG.sound.volume += 0.1;
					}
				}
			}
			else
			{
				volumeButton.borderStyle = NONE;
				volumeButton.color = FlxColor.WHITE;
			}
		}

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
