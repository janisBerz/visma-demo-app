
Write-Host "Restoring packages..." -BackgroundColor Blue
dotnet restore -v n

Write-Host "Building project..." -BackgroundColor Blue
dotnet build -v n

Write-Host "Publishing project..." -BackgroundColor Blue
dotnet publish -o Publish --no-build -v n

Write-Host "Creating folder structure..." -BackgroundColor Blue
New-Item -Path .\aws\temp\visma-demo-app -ItemType Directory -Force -Verbose
New-Item -Path .\aws\temp\packages -ItemType Directory -Force -Verbose

Write-Host "Staging artifacts..." -BackgroundColor Blue
Compress-Archive -Path .\Publish\* -DestinationPath .\aws\site.zip -Verbose -Force

Copy-Item .\aws\temp\aws-windows-deployment-manifest.json .\aws\visma-demo-app -Verbose

Move-Item .\aws\temp\site.zip .\aws\visma-demo-app -Verbose

Write-Host "Creating deployment package..." -BackgroundColor Blue
Compress-Archive -Path .\aws\temp\visma-demo-app\* -DestinationPath .\aws\packages\visma-demo-app.zip -Verbose -Force



