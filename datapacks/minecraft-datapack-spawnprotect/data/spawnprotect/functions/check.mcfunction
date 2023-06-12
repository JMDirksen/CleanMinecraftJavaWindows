schedule function spawnprotect:check 1s

# Assumption: Worldspawn is at: 0 70 0
# fill max blocks = 32768

# Remove Lava (y>=65)
execute at @a[x=-9,y=64,z=0,distance=..100] run fill ~-10 65 ~-10 ~10 100 ~10 air replace lava
execute at @a[x=-9,y=64,z=0,distance=..100] run fill ~-10 100 ~-10 ~10 150 ~10 air replace lava
execute at @a[x=-9,y=64,z=0,distance=..100] run fill ~-10 150 ~-10 ~10 200 ~10 air replace lava
execute at @a[x=-9,y=64,z=0,distance=..100] run fill ~-10 200 ~-10 ~10 255 ~10 air replace lava

# Remove primed TNT
kill @e[type=tnt,x=-9,y=64,z=0,distance=..100]

# Remove Creepers
tp @e[type=creeper,x=-9,y=64,z=0,distance=..100] 0 -1000 0

# Remove Wither
tp @e[type=wither,x=-9,y=64,z=0,distance=..100] 0 -1000 0
