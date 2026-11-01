name = "Nest sign"
ds_list_add(textList, "Chance of catching these Pokémon:")

var pool = GetNestEncounterPool(GameObject.areaKeyInfo)
var seen = ds_list_create()
var page = ""
var lines = 0
for (var i = 0; i < ds_list_size(pool); i++)
{
    var species = ds_list_find_value(pool, i)
    if (ds_list_find_index(seen, species) != -1) continue
    ds_list_add(seen, species)
    if (lines > 0) page = string_concat(page, "\n")
    page = string_concat(page, "- ", species)
    lines++
    // Keep the list within the existing dialogue box's height.
    if (lines == 3)
    {
        ds_list_add(textList, page)
        page = ""
        lines = 0
    }
}
if (page != "") ds_list_add(textList, page)
ds_list_add(textList, "Some of them are sleeping now. Come back later to find them all!")
ds_list_destroy(seen)
ds_list_destroy(pool)
