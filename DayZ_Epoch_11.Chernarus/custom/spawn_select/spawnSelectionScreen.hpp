class RscButton
{
	access = 0;
	type = 1;
	text = "";
	colorText[] = {0.8784,0.8471,0.651,1};
	colorDisabled[] = {0.4,0.4,0.4,1};
	colorBackground[] = {1,0.537,0,0.5};
	colorBackgroundDisabled[] = {0.95,0.95,0.95,1};
	colorBackgroundActive[] = {1,0.537,0,1};
	colorFocused[] = {1,0.537,0,1};
	colorShadow[] = {0.023529,0,0.0313725,1};
	colorBorder[] = {0.023529,0,0.0313725,1};
	soundEnter[] = {"\ca\ui\data\sound\onover",0.09,1};
	soundPush[] = {"\ca\ui\data\sound\new1",0,0};
	soundClick[] = {"\ca\ui\data\sound\onclick",0.07,1};
	soundEscape[] = {"\ca\ui\data\sound\onescape",0.09,1};
	style = 2;
	x = 0;
	y = 0;
	w = 0.;
	h = 0.04;
	shadow = 2;
	font = "Zeppelin32";
	sizeEx = 0.15;
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	borderSize = 0;
};
class spawnSelectionScreen_DIALOG
{
	idd=-1;
	movingenable=true;
	class Controls
	{
		class btnRandom: RscButton
		{
			idc = 1600;
			text = "Random";
			x = 0.35 * safezoneW + safezoneX;
			y = 0.35 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.15 * safezoneH;
			action = "closeDialog 0;spawnSelect = 100;";
		};
		class btnEvent1: RscButton
		{
			idc = 1601;
			text = "Event";
			x = 0.35 * safezoneW + safezoneX;
			y = 0.6 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.15 * safezoneH;
			action = "closeDialog 0;spawnSelect = 0;";
		};
		class lblMap: RscText
		{
			idc = 1000;
			text = "Choose 'Event', if you wanna participate and spawn in the event area. If not, choose 'Random'.";
			font = "Zeppelin32";
			type = 0;
			style = 18;
			lineSpacing = 1;
			sizeEx = 0.1;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.6 * safezoneW;
			h = 0.25 * safezoneH;
		};

	};
};
