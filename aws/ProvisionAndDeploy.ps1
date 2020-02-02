$ebApp = New-EBApplication -ApplicationName 'visma-demo-app'

(Get-EBAvailableSolutionStack).SolutionStackDetails

$ebAppParameters = @{
ApplicationName = 'visma-demo-app'
EnvironmentName = 'Development'
SolutionStack = '64bit Windows Server 2019 v2.5.0 running IIS 10.0'
Tier_Type = 'Standard'
Tier_name = 'WebServer'
}

New-EBEnvironment @ebAppParameters -Verbose

New-S3Bucket -BucketName 'visma-demo-app'

Write-S3Object -BucketName 'visma-demo-app' -File .\aws\temp\packages\visma-demo-app.zip

$versionLabel = [System.DateTime]::Now.Ticks.ToString()
$newParameters = @{
    ApplicationName = 'visma-demo-app'
    VersionLabel = $versionLabel
    SourceBundle_S3Bucket = 'visma-demo-app'
    SourceBundle_S3Key = 'visma-demo-app.zip'
}

New-EBApplicationVersion @newParameters

Update-EBEnvironment -ApplicationName 'visma-demo-app' -EnvironmentName 'Development' -VersionLabel $versionLabel

Get-EBEnvironment -ApplicationName 'visma-demo-app' -EnvironmentName 'Development'