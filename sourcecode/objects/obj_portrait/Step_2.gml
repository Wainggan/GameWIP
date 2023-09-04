delay -= global.delta_multi
anim = lerp(anim, instance_exists(owner) && delay <= 0 + 0, 1 - power(0.01, global.delta_milli * 8));
if !instance_exists(owner) && anim < 0.1 instance_destroy()