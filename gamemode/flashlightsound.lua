hook.Add( "KeyPress", "flashlight_soundbind", function( ply, key )
	if ( key == IN_USE ) then
		print( "hi" )
	end
end )