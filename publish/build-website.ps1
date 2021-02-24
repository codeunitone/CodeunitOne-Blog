
$buildTarget = '.\blog\public'

# clean up aka delete previous build
if (Test-Path $buildTarget) {
	Remove-Item $buildTarget -Recurse -Force
}

# build website
hugo -s .\blog

# generate .htaccess file
$htaccessContent = @(
	'RewriteEngine On',
	'RewriteCond %{HTTPS} off',
	'RewriteRule .* https://codeunitone.net/$1 [R=301,L]'
)
$htaccessPath = Join-Path $buildTarget -ChildPath '.htaccess'
Set-Content -Path $htaccessPath -Value $htaccessContent