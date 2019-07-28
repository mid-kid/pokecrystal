ItemFinder:
	farcall CheckForHiddenItems
	jr c, .found_something
	ld hl, .Script_FoundNothing
	jr .resume

.found_something
	ld hl, .Script_FoundSomething

.resume
	call QueueScript
	ld a, $1
	ld [wItemEffectSucceeded], a
	ret

.ItemfinderSound:
	ld c, 4
.sfx_loop
	push bc
	ld de, SFX_SECOND_PART_OF_ITEMFINDER
	call WaitPlaySFX
	ld de, SFX_TRANSACTION
	call WaitPlaySFX
	pop bc
	dec c
	jr nz, .sfx_loop
	ret

.Script_FoundSomething:
	reloadmappart
	special UpdateTimePals
	callasm .ItemfinderSound
	writetext .ItemfinderNearbyText
	closetext
	end

.Script_FoundNothing:
	reloadmappart
	special UpdateTimePals
	writetext .ItemfinderNothingText
	closetext
	end

.ItemfinderNearbyText:
	text_far _ItemfinderNearbyText
	text_end

.ItemfinderNothingText:
	text_far _ItemfinderNothingText
	text_end
