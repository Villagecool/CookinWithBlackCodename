import flixel.addons.display.FlxBackdrop;
import openfl.display.BlendMode;


var space:FlxBackdrop;
var spacef:FlxBackdrop;
var changing:Float = 0;
var black:FlxSprite;

function create() {
    space = new FlxBackdrop().loadGraphic(Paths.image('stages/spacejam/space-1'));
    space.screenCenter();
    space.velocity.x = -10000;
    space.velocity.y = -100;
    space.cameras = [camGame];
    space.scale.x = space.scale.y = 1.25;
    //add(space);
    insert(0,space);
    
    spacef = new FlxBackdrop().loadGraphic(Paths.image('stages/spacejam/space-f-1'));
    spacef.screenCenter();
    spacef.velocity.x = -5000;
    spacef.velocity.y = -50;
    spacef.alpha = 0.2;
    spacef.scale.x = spacef.scale.y = 3;
    spacef.cameras = [camGame];
    //add(spacef);
    insert(2,spacef);

    
	black = new FlxSprite(0, 0).makeSolid(FlxG.width, FlxG.height, FlxColor.BLACK);
    black.cameras = [camHUD];
    black.visible = false;
    add(black);
}
function postCreate() {
    
	for (sl in strumLines.members) { for (note in sl.members) { note.alpha = 0; }}

    stage.getSprite("fire").blend = BlendMode.ADD;
    stage.getSprite("fire2").blend = BlendMode.ADD;
}
function update() {
    changing+=0.05;
    dad.y = boyfriend.y = 50 + Math.sin(changing)*20;
    stage.getSprite("shit-front").y = Math.sin(changing)*20;
    stage.getSprite("shit-back").y = Math.sin(changing)*20;
    stage.getSprite("fire").y = 229 + Math.sin(changing)*20;
    stage.getSprite("fire2").y = -96 + Math.sin(changing)*20;
    
    //camGame.angle = Math.sin(changing*0.01)*20;
}
function stepHit(curStep) {
    if (curStep % 60 == 58 && curStep > 268 && curStep < 1948) spawnGuy();
    if (curStep == 1) {
        for (sl in strumLines.members) { for (note in sl.members) { note.alpha = 0; }}; 
        //FlxTween.tween(camGame, {angle: 0},40, { ease: FlxEase.expoOut });
     }
	if (curStep == 268 || curStep == 1948) {
        black.visible = true;
    }
	if (curStep == 272) {
		black.visible = false;
	    for (sl in strumLines.members) { for (note in sl.members) { note.alpha = 1; }}
        FlxTween.tween(camHUD, {alpha: 1},0.5, { ease: FlxEase.linear });
    }
	if (curStep == 1952) {
		black.visible = false;
        space.velocity.x = -50;
        space.velocity.y = -5;
        spacef.velocity.x = -100;
        spacef.velocity.y = -10;
        spacef.alpha = 0.5;
        
        space.loadGraphic(Paths.image('stages/spacejam/space-2'));
        spacef.loadGraphic(Paths.image('stages/spacejam/space-f-2'));

        stage.getSprite('store-ig').alpha = 1;
        FlxTween.tween(stage.getSprite('store-ig'), {x: 0}, 3, { ease: FlxEase.expoOut });

        //doTweenX('fireGone', 'ship-fire.scale', 0, 2, 'expoinout')
        //doTweenX('fireGone2', 'ship-fire', getProperty('ship-fire.x')+100, 2, 'expoinout')

        //playAnim('bg', 'idle-stop');
    }
}
function spawnGuy() {
    var guy:FlxSprite = new FlxSprite(FlxG.width*5,FlxG.random.int(FlxG.height*-1.5, FlxG.height*2));
    guy.loadGraphic(Paths.image('stages/spacejam/thing'+FlxG.random.int(1, 8)));
    add(guy);
    guy.scale.x = guy.scale.y = 3;
    FlxTween.tween(guy, {x: FlxG.width*-5, angle: 360*2}, 2, { ease: FlxEase.linear, onComplete:function(twn:FlxTween) {guy.destroy();} });
}