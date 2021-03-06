# Gets card data from scryfall for the given query
[string]$Set = 'stx'
[string]$Query = "set:$($Set) (rarity:c OR rarity:u)"
[string]$URI = "https://api.scryfall.com/cards/search?q=$([uri]::EscapeDataString($Query))"
$Cards = @()
$Cards += Invoke-RestMethod -Uri $URI

# Formats the cards into MTGA deck import format
$FormattedCards = @()
$FormattedCards += ($Cards.data | Select-Object -Property @{ Name = 'Entry';  Expression = {"4 $($_.Name) ($($_.set)) $($_.collector_number)"}}).Entry

# MTGA limits decklists to 250 total cards which is 62 playsets.
[int]$CardCount = $FormattedCards.count * 4
[int]$Skip = 0
[int]$UniqueCardsPerDeck = 62
[int]$TotalDeckLists = [Math]::Round($CardCount/($UniqueCardsPerDeck * 4))

# Exports text files to the same directory as this script file
1..$TotalDeckLists | ForEach-Object -Process {
    [string[]]$Clip = @('Deck')
    $Clip += $FormattedCards | Select-Object -Skip $Skip -First $UniqueCardsPerDeck
    $Clip | Out-File -FilePath "$($PSScriptRoot)\$($Skip)deck.txt"
    $Skip += $UniqueCardsPerDeck
}
