import funkin.options.OptionsMenu;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import funkin.menus.credits.CreditsMain;

import flixel.util.FlxColor;
import flixel.text.FlxText.FlxTextFormat;
import flixel.text.FlxText.FlxTextBorderStyle;

var menuOptions:Array<String> = ['story','free','credits','options'];
var menuObjects:Array<Dynamic> = [];
var curSelected = 0;
var versionShit:FlxText;
var logo:FunkinSprite;

function create()
{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
  FlxG.camera.bgColor = 0xFF999999;
  FlxG.mouse.visible = true;

    logo = new FunkinSprite(0,0, Paths.image('menus/logoBumpin'));
	logo.addAnim('idle', '', 24);
    logo.playAnim('idle');
    logo.scrollFactor.set(0.5,0.5);
    logo.screenCenter();
    logo.x += 600;
    add(logo);

   var menuBG:FlxSprite = new FlxSprite(0,0);
   menuBG.loadGraphic(Paths.image('menus/mainmenu/tabel'));
   menuBG.screenCenter();
   add(menuBG);

   var menuBGE:FlxSprite = new FlxSprite(0,0);
   menuBGE.loadGraphic(Paths.image('menus/mainmenu/extras'));
   menuBGE.screenCenter();
   add(menuBGE);

	versionShit = new FlxText(12, FlxG.height - 64, 0, "Cooking With Black", 12);
	//versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

    for (i => x in menuOptions) {
        var thing:FunkinSprite = new FunkinSprite(0,0, Paths.image('menus/mainmenu/menu-options'));
		thing.addAnim('idle', x+'0', 3, true);
		thing.addAnim('selected', x+"-sel", 12, true);
		thing.playAnim('idle');
        thing.ID = i;
        thing.screenCenter();
        add(thing);
        menuObjects.push(thing);
    }
	//add(versionShit);
}

var lastCurSelected = 0;
function update(elapsed:Float)
{
    FlxG.camera.zoom = 0.6/*-(Math.abs(distance(FlxG.width/2, FlxG.height/2, FlxG.mouse.screenX, FlxG.mouse.screenY))*0.00005)*/;
    FlxG.camera.scroll.x = (FlxG.mouse.screenX-FlxG.width/2)*0.05;
    FlxG.camera.scroll.y = (FlxG.mouse.screenY-FlxG.height/2)*0.02;

    //versionShit.text = FlxG.mouse.x + ', ' + FlxG.mouse.y;

    //if(FlxG.keys.justPressed.ESCAPE)
    //{
    //    FlxG.switchState(new TitleState());
    //}

    if(FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.DOWN) changeSel(1);
    if(FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.UP) changeSel(-1);

    if((FlxG.keys.justPressed.ENTER || FlxG.mouse.justPressed) && curSelected != -1 )
    {
        FlxG.sound.play(Paths.sound('menu/confirm'));

        switchCrossState();
    }

    if (FlxG.mouse.justMoved) {
        if (mouseInBox([82,-198,817,312])) curSelected = 0;
        else if (mouseInBox([-260,547,425,775])) curSelected = 1;
        else if (mouseInBox([400,400,1000,700])) curSelected = 2;
        else if (mouseInBox([-179,225,278,482])) curSelected = 3;
        else curSelected = -1;

        changeSel();
    }
    if (lastCurSelected != curSelected) {FlxG.sound.play(Paths.sound("menu/volume"), 0.5);}
    lastCurSelected = curSelected;

    if(controls.SWITCHMOD)
    {
        persistentUpdate = !(persistentDraw = true);
		openSubState(new ModSwitchMenu());
    }

    if (FlxG.keys.justPressed.SEVEN) {
		persistentUpdate = !(persistentDraw = true);
		openSubState(new EditorPicker());
	}
}

function changeSel(to:Int = 0) {
    curSelected = FlxMath.wrap(curSelected + to, -1, menuOptions.length - 1);
    for (mf in menuObjects) {
		mf.playAnim('idle');
    }
    if (curSelected != -1) menuObjects[curSelected].playAnim('selected');
}
function switchCrossState()
{
    switch(curSelected)
    {
        case 0:
            FlxG.switchState(new StoryMenuState());
        case 1:
            FlxG.switchState(new FreeplayState());
        case 3:
            FlxG.switchState(new OptionsMenu());
        case 2:
            FlxG.switchState(new CreditsMain());
    }
}
function distance(x1, y1, x2, y2) {
  var dx:Float = x2 - x1;
  var dy:Float = y2 - y1;
  return Math.sqrt(dx * dx + dy * dy);
}

var startMousePos:FlxPoint = new FlxPoint();
function mouseInBox(coords:Array<Int>) {
	//FlxG.mouse.getScreenPosition(FlxG.camera, startMousePos);
    return (FlxG.mouse.x >= coords[0] && FlxG.mouse.x <= coords[2] &&
			FlxG.mouse.y >= coords[1] && FlxG.mouse.y <= coords[3]);
}
function beatHit(curBeat:Int) {
    logo.playAnim('idle', true);
}