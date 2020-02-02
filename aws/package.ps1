
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
Compress-Archive -Path .\Publish\* -DestinationPath .\aws\temp\site.zip -Verbose -Force

Copy-Item .\aws\aws-windows-deployment-manifest.json .\aws\temp\visma-demo-app\aws-windows-deployment-manifest.json -Verbose -Force

Move-Item .\aws\temp\site.zip .\aws\visma-demo-app -Verbose

Write-Host "Creating deployment package..." -BackgroundColor Blue
Compress-Archive -Path .\aws\temp\visma-demo-app\* -DestinationPath .\aws\temp\packages\visma-demo-app.zip -Verbose -Force




