package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;

class DebugArea extends FlxState
{
	var _sprite:FlxSprite;

	var waveEffect:FlxWaveEffect;

	override public function create()
	{
		super.create();

		FlxG.sound.music.pause();

		_sprite = new FlxSprite(0, 0);
		_sprite.loadGraphic(AssetPaths.Water200__png);

		// wave animation

		var waveEffect = new FlxWaveEffect(FlxWaveMode.ALL, 4, -1, 4);
		var waveSprite = new FlxEffectSprite(_sprite, [waveEffect]);
		add(waveSprite);

		_sprite.scale.set(2, 1);
		_sprite.screenCenter();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
