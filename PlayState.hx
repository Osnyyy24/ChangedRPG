package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	var titleTween:FlxTween;
	var title:FlxText;
	var bg:FlxSprite;

	var whiteTween:FlxTween;
	var blackTween:FlxTween;

	override public function create()
	{
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			onTransition();
		});

		bg = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height);
		bg.color = FlxColor.BLACK;
		bg.screenCenter();
		add(bg);

		title = new FlxText(0, 100, 0, "ChangedRPG", 24);
		title.setFormat(AssetPaths.Crang__ttf, 46, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		title.alignment = LEFT;
		title.alpha = 0;
		title.screenCenter();
		add(title);

		FlxG.sound.music.pause();

		super.create();
	}

	function onTransition()
	{
		FlxG.sound.play(AssetPaths.TransitionsHit__ogg, 0.7);
		titleTween = FlxTween.tween(title, {alpha: 1}, 0.5);
		titleTween.ease = FlxEase.cubeIn;
		new FlxTimer().start(0.6, function(buzzsound:FlxTimer)
		{
			var sound = FlxG.sound.play(AssetPaths.BuzzAndOpen34__ogg, 1);
			sound.onComplete = function()
			{
				whiteTransition();
			};
		});
	}

	function whiteTransition()
	{
		titleTween = FlxTween.tween(title, {alpha: 0}, 0.5);
		titleTween.ease = FlxEase.sineIn;
		whiteTween = FlxTween.color(bg, 0.5, FlxColor.BLACK, FlxColor.WHITE);
		whiteTween.ease = FlxEase.sineIn;
		new FlxTimer().start(0.6, function(blackt:FlxTimer)
		{
			blackTween = FlxTween.color(bg, 0.5, FlxColor.WHITE, FlxColor.BLACK);
		});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
