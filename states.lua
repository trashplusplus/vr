function drawMenu(pass)
	pass:skybox(test)
		pass:text("Select HDR Box:", 0, 5, -1)
		for i, v in ipairs(allTabs) do
			pass:setColor(1, 0.5, 1, 1)
			pass:plane(v.x, v.y, v.z, v.w, v.h)
			pass:setColor(1,1,1,1)
			pass:text(v.title, v.x, v.y, v.z + 0.1)
		 end
		 
		 pass:text(">>> ", -10, allTabs[cursor].y, -1)
end

function drawSky(pass)
	pass:skybox(currentSkyBox)
end
