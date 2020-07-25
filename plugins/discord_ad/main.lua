register_plugin("Professor Brain", "Discord advertising", "none", "none")

function ad()
	local ad_msg = "^1Join to discord server: ggproject.xyz/discord\nIts not a problem to report somebody or get help!\n"
	local say_text = reg_user_msg("SayText", -1)
	message_begin(2, say_text, {0, 0, 0}, 0)
	write_byte(1)
	write_string(ad_msg)
	message_end()
end
set_task("advertising_delay",-1,180,"ad")
