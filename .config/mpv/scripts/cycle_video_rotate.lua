function cycle_video_rotate(direction)
	-- Calculate what the next rotation value should be.
	newrotate = mp.get_property_number("video-rotate")
	if direction == "clockwise" then
		newrotate = newrotate + 90
	else
		newrotate = newrotate - 90
	end
	-- Wrap value to correct range (0 (aka 360) to 359).
	if newrotate >= 360 then
		newrotate = newrotate - 360
	elseif newrotate < 0 then
		newrotate = newrotate + 360
	end
	-- Change rotation and tell the user.
	mp.set_property_number("video-rotate", newrotate)
	mp.osd_message("Rotate: " .. newrotate)
end

mp.add_key_binding(nil, "Cycle_Video_Rotate", cycle_video_rotate)
