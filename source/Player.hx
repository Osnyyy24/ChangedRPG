package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.sound.FlxSound;

class Player extends FlxSprite
{
	static inline var SPEED:Float = 60;
	static inline var RUN_SPEED_MULTIPLIER:Float = 2.0;

	var tabPressed:Bool = false;
	var stepSound:FlxSound;

	var hitbox:FlxRect;

	/**
	 * This Class create a player for you with a "new Player();"
	 * @param x position x of the player
	 * @param y position y of the player
	 */
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		loadGraphic(AssetPaths.xddd__png, true, 18, 31);
		setFacingFlip(LEFT, false, false);
		setFacingFlip(RIGHT, true, false);
		// idles
		animation.add("down_idle", [0]);
		animation.add("leftright_idle", [3]);
		animation.add("up_idle", [6]);
		// waiting to add more anims :3
		// walks
		animation.add("down_walk", [1, 2], 6);
		animation.add("leftright_walk", [4, 5], 6);
		animation.add("up_walk", [6, 7], 6);

		drag.x = drag.y = 800;

		scale.set(2, 2);
		offset.set(4, 8);

		hitbox = new FlxRect(x, y + height / 2, width, height / 2);

		stepSound = FlxG.sound.play(AssetPaths.step__wav);
	}

	override function update(elapsed:Float)
	{
		updateDaHitbox();
		updateMovement();
		super.update(elapsed);
	}

	function updateDaHitbox()
	{
		hitbox.x = x;
		hitbox.y = y + height / 2;
	}

	function updateMovement()
	{
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;
		tabPressed = FlxG.keys.anyPressed([FlxKey.TAB]);

		#if FLX_KEYBOARD
		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);
		#end

		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;

		var currentSpeed:Float = SPEED;

		if (tabPressed)
		{
			// Si Shift está presionado, aumenta la velocidad
			currentSpeed *= RUN_SPEED_MULTIPLIER;
		}

		if (up || down || left || right)
		{
			var newAngle:Float = 0;
			if (up)
			{
				newAngle = -90;
				if (left)
					newAngle -= 45;
				else if (right)
					newAngle += 45;
				facing = UP;
			}
			else if (down)
			{
				newAngle = 90;
				if (left)
					newAngle += 45;
				else if (right)
					newAngle -= 45;
				facing = DOWN;
			}
			else if (left)
			{
				newAngle = 180;
				facing = LEFT;
			}
			else if (right)
			{
				newAngle = 0;
				facing = RIGHT;
			}

			// determine our velocity based on angle and speed
			velocity.setPolarDegrees(currentSpeed, newAngle);
		}

		var action = "idle";
		// check if the player is moving, and not walking into walls
		if ((velocity.x != 0 || velocity.y != 0) && touching == NONE)
		{
			stepSound.play();
			action = "walk";
		}

		switch (facing)
		{
			case LEFT, RIGHT:
				animation.play("leftright_" + action);
			case UP:
				animation.play("up_" + action);
			case DOWN:
				animation.play("down_" + action);
			case _:
		}
	}
}
