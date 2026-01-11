import funkin.options.OptionsMenu;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import funkin.menus.credits.CreditsMain;

import funkin.menus.StoryMenuState.StoryWeeklist;

import flixel.util.FlxColor;
import flixel.text.FlxText.FlxTextFormat;
import flixel.text.FlxText.FlxTextBorderStyle;

var menuOptions:Array<String> = [];
var weeks:Array<String> = [];
var menuObjects:Array<Dynamic> = [];
var curSelected = 0;
var versionShit:FlxText;
var theShit:FunkinSprite;
var binder2:FlxSprite;

function create()
{
	//FlxG.sound.playMusic(Paths.music('freakyMenu'));

    
   var menuBG:FlxSprite = new FlxSprite(0,0);
   menuBG.loadGraphic(Paths.image('menus/story/tabel'));
   menuBG.scale.x = menuBG.scale.y = 0.6;
   menuBG.screenCenter();
   add(menuBG);
   
   var binder:FlxSprite = new FlxSprite(0,0);
   binder.loadGraphic(Paths.image('menus/story/binder'));
   binder.scale.x = binder.scale.y = 0.6;
   binder.screenCenter();
   binder.x += 250;
   add(binder);
   
   binder2 = new FlxSprite(0,0);
   binder2.loadGraphic(Paths.image('menus/story/ring_overlay'));
   binder2.scale.x = binder2.scale.y = 0.6;
   binder2.screenCenter();
   binder2.x += 250;

	theShit = new FlxText(10, 10, 0, "\n", 36);
	//versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

    for (i => week in StoryWeeklist.get().weeks) {
        menuOptions.push(week.id);
        weeks.push(week);
    }
    for (i => x in menuOptions) {
        theShit.text += "\n  "+x;

        var thing:FunkinSprite = new FunkinSprite(0,0, Paths.image('menus/story/week'+(i+1)));
        thing.ID = i;
        thing.screenCenter();
        thing.x = FlxG.width - 100;
        thing.scale.x = thing.scale.y = 0.6;
        thing.origin.x = 20;
        thing.flipX = true;
        add(thing);
        menuObjects.push(thing);
    }
	add(theShit);
    add(binder2);
    changeSel();
}

function update(elapsed:Float)
{
    if(FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.DOWN) changeSel(1);
    if(FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.UP) changeSel(-1);

    if((controls.ACCEPT) && curSelected != -1 )
    {
        FlxG.sound.play(Paths.sound('menu/confirm'));

        switchCrossState();
    }

    if ((controls.BACK || FlxG.keys.justPressed.ESCAPE)) {
        FlxG.switchState(new MainMenuState());
    }
    if(controls.SWITCHMOD)
    {
        persistentUpdate = !(persistentDraw = true);
		openSubState(new ModSwitchMenu());
    }

}

function changeSel(to:Int = 0) {
    curSelected = FlxMath.wrap(curSelected + to, 0, menuOptions.length - 1);
    if (to != 0) FlxG.sound.play(Paths.sound("menu/volume"), 0.5);

    theShit.text = "\nNegative Space\nThat needs filled\nStory Mode\n\nSelect Week\n"+weeks[curSelected].name+'\n';
    for (i => x in menuOptions) {
        theShit.text += "\n"+(i == curSelected ? '> ': '  ')+x;
    }
    
    for (i => thing in menuObjects) {
        FlxTween.tween(thing.scale, {x: (thing.ID > curSelected ? 0.6 : -0.6)}, 1.5, { startDelay: i*0.2, ease: FlxEase.expoOut });
    }
    
    //FlxTween.tween(binder2, {alpha: 0}, 0.1, { startDelay: 0.4, ease: FlxEase.linear });
    //FlxTween.tween(binder2, {alpha: 1}, 0.1, { startDelay: 0.5, ease: FlxEase.linear });
    //theShit.y = curSelected*-32;
}
function switchCrossState()
{
    weekPlaylist = weeks[curSelected].songs;
    weekDifficulty = 'normal';
    PlayState.loadWeek(weeks[curSelected], 'normal');
    //PlayState.loadSong(weeks[curSelected], 'normal', false, false);
    //new FlxTimer().start(1, function() {
    weekPlaylist.shift();
    FlxG.switchState(new PlayState());
    //});
}