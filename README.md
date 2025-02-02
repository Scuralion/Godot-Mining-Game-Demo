<p align="justify">
Small Demo of a Mining Game I made with Godot (Version 4.2).
The Demo Features a small Area with Static and Minable Blocks.
Some Blocks spawn Crystals which can be collected and are beeing kept track of.
Blocks block the vision and the TileMap updates accordingly if blocks get destroyed.
 </p>
 
![Screenshot (163)](https://github.com/user-attachments/assets/321fa1a6-ebde-481e-a1b4-13db82ab8c6b)
<p align="justify">
The Player features a Basic Top-Down Movement script.
The heart of the Project is the Mining Tool, consisting of Two components,
the "BeamComponent", dealing with the visual appearance of a Mining-Laser and the "DamageComponent", handling all things damage related.
These can be easily modified and serve as abstract classes for a wide variety of possible Mining Tools with different appearances and functionality you can dream up.
  
The Laser is in essence a combination of spleens modulating the width and color intensity of a Line2D,
as well as multiple ParticleEmitters giving the impression of flowing energy and impact.
 </p>

![Screenshot (164)](https://github.com/user-attachments/assets/b25a68a0-d8a8-4164-95a0-1155561a1d8f)
<p align="justify">
The Basic TileSprites are modified Versions of a MiningTileset from from maxvuksan: https://itch.io/profile/maxvuksan
They were published stating: "Use of this art is completely free" and the same applies to my modified versions.
Other Assets, including Mining-shadows, crystals and others were made by me and are also free - make something cool with them!

OF NOTE:
This Project was done in Godot 4.2 and as such makes use of the deprecated TileMap Node.
For Autotiling i relied on "Better Terrain" from "Portyponk": https://github.com/Portponky
which as of publishing this, is not updated to work with the new TileMapLayer Node that superceded TileMaps.
If you want to move with TileMapLayers, you will need to rework the autotiling system accordingly.
 </p>
