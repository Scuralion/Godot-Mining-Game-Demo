Small Demo of a Mining Game made with Godot.
The Demo Features a small Area with Static and Minable Blocks.
Some Blocks spawn Crystals which can be collected and are beeing kept track of.
Blocks block the vision and the TileMap updates accordingly if blocks get destroyed.

The Player features a Basic Top-Down Movement script.
The heart of the Project is the Mining Tool, consisting of Two components,
the "BeamComponent", dealing with the visual appearance of a Mining-Laser and the "DamageComponent", handling all things damage related.
These can be easily modified and serve as abstract classes for a wide variety of possible Mining Tools with different appearances and functionality you can dream up.

The Laser is in essence a combination of spleens modulating the width and color intensity of a Line2D,
as well as multiple ParticleEmitters giving the impression of flowing energy and impact.![Screenshot (163)](https://github.com/user-attachments/assets/321fa1a6-ebde-481e-a1b4-13db82ab8c6b)
