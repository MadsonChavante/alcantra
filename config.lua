--
-- For more information on config.lua see the Project Configuration Guide at:
-- https://docs.coronalabs.com/guide/basics/configSettings
--

application =
{
	content =
	{
		width = 320,
		height = 480, 
		scale = "zoomStretch",
		--fps = 60,
		--[[]
		graphicsCompatibility = 1,
		width = 320,
		height = 480,
		scale = "zoomStretch",
		
		imageSuffix =
		{
			["@15x"] = 1.5,
			["@2x"] = 2.1,
		},

        fps = 30,
		--]]

		--[[
		imageSuffix =
		{
			    ["@2x"] = 2,
			    ["@4x"] = 4,
		},
		--]]
	},
}
