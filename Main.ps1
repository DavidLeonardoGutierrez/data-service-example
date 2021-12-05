Import-Module ./kubernetes/DeploymentLibrary
Import-Module ./services/data-loader-job/DeploymentLibrary
Import-Module ./terraform/DeploymentLibrary


#---------functions
function Read-ConfigurationFile {
    
    Get-Content -Raw -Path configuration.json | ConvertFrom-Json
}

function Wait-ForUser{
    Write-Host -ForeGround Yellow -NoNewLine 'Press any key to continue...';

    #Wait for the user :) 
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}

function Main {

    $Configuration = Read-ConfigurationFile

    Build-AzureResources $Configuration.terraform
    Build-DataLoaderJobImage $Configuration.dataLoaderJob $true
    Start-Cluster $Configuration.kubernetes
    Wait-ForUser
    Remove-Cluster
    Remove-AzureResources $Configuration.terraform
}

#-----------Main execution
Main