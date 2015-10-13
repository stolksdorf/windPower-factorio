
## Steps for making a Factorio Animation Sheet
1. Find a Sketchup model
1. Style it with textures
1. Setup a properly angled scene with shadows
1. Confgure the automation script to automatically rotate and export the model with and without shadows
1. Run the `createAnimationSheet.js` script on the resultant raw images
1. Profit.



###Getting Base Models
1. https://3dwarehouse.sketchup.com/index.html

###Textures
1. Head to [Mayang's Free Textures](http://www.mayang.com/textures/)
1. There's a ton of great rusted and corroded metal textures under [flat metal](http://www.mayang.com/textures/Metal/html/Flat%20Metal%20Textures/index.html)
1.

### Rotation
To rotate part of the model create a component out of the surfaces you want to rotate

1. Select the surfaces
1. Right-click `Make Component`
1. Then do a `move and clone`, select the move tool, click the component, hold control and move.
1. Move the part away from the scene, and maintain the axis you wish to rotate
1. Select all surfaces on the cloned component, and right-click `make group`, this will allow you to rotate it all at once

### Setup to export
1. Enable shadows, `menu > view > shadows`
1. Open the shadow, styles, and scene window, `menu > view > shadows,styles,scenes`


### How To Setup the automated exporting
1. Make sure you have the Sketchup windows aligned along the side
1. Center your model properly and save that to the Money Shot frame
1. Do one export to set up the pathing properly. **important**: set the export options each time, make the width 5000px and make the height match

1. Clean out the /raw for your model, then run the script

1. Open up one of the raw images in Paint.net to find the crop coordinates, and add those to the `sheet_config.json`
1.



