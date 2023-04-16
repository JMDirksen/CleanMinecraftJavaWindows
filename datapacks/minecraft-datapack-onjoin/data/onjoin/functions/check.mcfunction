schedule function onjoin:check 5s

# Make sure all online players have a onjoin score set
scoreboard players add @a onjoin 0

# Send message to players with a onjoin score of 0
execute as @a[scores={onjoin=0}] run function onjoin:message

# Set onjoin score to 1 only for online players
scoreboard players set * onjoin 0
scoreboard players set @a onjoin 1
