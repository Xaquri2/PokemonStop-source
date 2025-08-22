if (buyQuantity < 999 and GetItemValue(buyItem)*(buyQuantity+1) <= global.money)
{
	buyQuantity++
	if (quickIncrementValue > 5) quickIncrementValue /= 2
	alarm[0] = quickIncrementValue
}