
var banginShaderMg:CustomShader = new CustomShader("BWShader");

function onEvent(event) {
	if (event.event.name == "Black White Outline") {
		var active = event.event.params[0];

    banginShaderMg.invert = true;
    banginShaderMg.lowerBound = 0.05;
    banginShaderMg.upperBound = 0.04;
    if (active == true)
      camGame.addShader(banginShaderMg);
    else
      camGame.removeShader(banginShaderMg);

		//if (rm == true) {
		//	char.shader = new CustomShader(shaderName);
		//	char.shader.color = [0, 0, 0, 0];
		//	char.shader.shadowLength = 0;
		//	char.color = FlxColor.fromHSL(char.color.hue, char.color.saturation, 1, 1);
		//} else {
		//	char.shader = new CustomShader(shaderName);
		//	char.shader.color = [rd, gn, bl, ap];
		//	char.shader.shadowLength = ssz;
		//	char.shader.flipped = xy;
		//	char.color = FlxColor.fromHSL(char.color.hue, char.color.saturation, shb, shb);
		//}
	}
}



