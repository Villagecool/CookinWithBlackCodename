import flixel.FlxCamera;
import flixel.FlxG;
import hxvlc.flixel.FlxVideoSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.effects.FlxFlicker;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import openfl.display.BlendMode;


function postCreate() {
    //stage.getSprite("holy").alpha = 1;
    //stage.getSprite("fire").blend = BlendMode.ADD;
    stage.getSprite("fire").camera = camHUD;
    //stage.getSprite("artist").camera = camHUD;
}

function artist(id:String) {
    stage.getSprite("artist").alpha = 1;
    stage.getSprite("artist").animation.play(id);
}
function cuh() {
	for (sl in strumLines.members) { for (note in sl.members) { note.alpha = 0; }}
    stage.getSprite("holy").alpha = 1;
    stage.getSprite("artist").alpha = 0;
    stage.getSprite("cuh").alpha = 0.9;
    FlxTween.tween(stage.getSprite("fire"), {alpha: 0.75}, 6, { ease: FlxEase.linear });
    FlxTween.tween(stage.getSprite("cuh"), {alpha: 1, y: -800}, 20, { ease: FlxEase.quartOut });
}
function dancintime() {
    stage.getSprite("defaultdance").alpha = 0.9;
    stage.getSprite("hecan").screenCenter();
    stage.getSprite("defaultdance").screenCenter(FlxAxes.Y);
    FlxTween.tween(stage.getSprite("hecan"), {alpha: 1}, 6, { ease: FlxEase.linear });
    FlxTween.tween(stage.getSprite("defaultdance"), {x: 2400}, 5, { startDelay: 5, ease: FlxEase.linear });
}
function nocuh() {
	for (sl in strumLines.members) { for (note in sl.members) { note.alpha = 1; }}
    stage.getSprite("holy").alpha = 0;
    stage.getSprite("defaultdance").alpha = 0;
    stage.getSprite("cuh").alpha = 0;
    stage.getSprite("fire").alpha = 0;
    stage.getSprite("hecan").alpha = 0;
}