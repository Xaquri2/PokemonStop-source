// Keep a due autosave pending until the overworld player is available again.
if (global.autosave and !SaveStateAction(global.latestSaveState, "Save")) alarm[1] = 60
