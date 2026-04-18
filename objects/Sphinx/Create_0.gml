// Inherit the parent event
event_inherited();

name = "Sphinx"

ds_list_add(textList, "There's a weird statue on a pedestal. The pedestal has a plaque.",
"The plaque reads:",
"The Mighty Sphinx. Answer her riddle, if you wish to pass.","Hear me! I am the Sphinx!",
"Answer my riddle:",
"Which creature has one voice and yet becomes four-footed and two-footed and three-footed?")
ds_list_add(nameList, "", "", "","Sphinx","Sphinx","Sphinx","Sphinx")
ds_list_add(iconList, SphinxSprite,SphinxSprite,SphinxSprite,SphinxSprite,SphinxSprite,SphinxSprite,SphinxSprite)

RiddleSolved = false;
fading_started = false;


