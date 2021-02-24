param (
	[Parameter(Mandatory = $true)]
	[string]
	$title
)

$blogPostPath = $(join-path '.\blog\content\post' -ChildPath $(Get-Date -Format yyyy))

if (!(Test-Path $blogPostPath)) {
	New-Item $blogPostPath -ItemType Directory | Out-Null
}

# #get most recent number
# [string]$(Get-ChildItem -Path $blogPostPath | Sort-Object Name -Descending | Select-Object -First 1).Name.Substring(0, 3)
$directoryContent = Get-ChildItem -Path $blogPostPath
if ($($directoryContent | Measure-Object).Count -eq 0) {
	$MostRecentFileNumber
}
else {
	[int] $MostRecentFileNumber = [string]$($directoryContent | Sort-Object Name -Descending | Select-Object -First 1).Name.Substring(0, 3)
}

# create a new blog post file
[string]$newFileNumber = $($MostRecentFileNumber + 1)
$newFileNumber = $newFileNumber.PadLeft(3, '0')
$newFileName = Join-Path $blogPostPath -ChildPath $("$newFileNumber - $title.md")

$content = @(
	'---',
	$('title: {0}' -f $title) + ,
	# $('date: ' + $(Get-Date -Format o | ForEach-Object { $_ -replace ":", "." })),
	$('date: {0}' -f $(Get-Date -Format o )),
	'tags: ["",""]',
	'draft: true',
	'---'
)
Set-Content -Path $newfileName -Value $content