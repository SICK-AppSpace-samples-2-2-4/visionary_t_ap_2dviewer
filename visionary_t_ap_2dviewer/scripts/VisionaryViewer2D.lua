--[[----------------------------------------------------------------------------

 Showing distance, intensity and confidence images in separate views.

------------------------------------------------------------------------------]]

local deco = View.ImageDecoration.create()
deco:setRange(0, 10000)

-- Create the camera handle
local camera = Image.Provider.Camera.create()
-- Create handle for all three views
local vDistance = View.create('distanceViewer')
local vIntensity = View.create('intensityViewer')
local vConfidence = View.create('confidenceViewer')

local function main()
  -- Starting the camera
  camera:start()
end
--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event
Script.register('Engine.OnStarted', main)

--@handleOnNewImage(image:Image, sensordata:SensorData)
local function handleOnNewImage(image)
  vDistance:addImage(image[1], deco) --distance image is first element of the image table
  vIntensity:addImage(image[2], deco) --intensity image is second element of the image table
  vConfidence:addImage(image[3], deco) --confidence map is third element of the image table

  -- Present the added images
  vDistance:present()
  vIntensity:present()
  vConfidence:present()
end
--Registration of the 'handleOnNewImage' function to the cameras "OnNewImage" event
Image.Provider.Camera.register(camera, 'OnNewImage', handleOnNewImage)
