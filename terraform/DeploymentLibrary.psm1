New-Module -Name TerraformModule -ScriptBlock {
    <#
     .Synopsis
      Builds the Azure resources.
    
     .Description
      The mocule uses terraform to create the Azure resources needed by the services.
    #>
    function Build-AzureResources {
    
        Param(
          [parameter(mandatory=$true)] $azureConfiguration
        )

        Set-Location ./terraform/module
    
        Write-Host "Building Azure infrastructure..." -ForeGround Yellow

        #terraform initialization
        terraform init 

        $resourceGroupVar = "resource_group_name=" + $azureConfiguration.resourceGroupName
        $regionVar = "default_region=" + $azureConfiguration.region
        $cosmosAccountNameVar = "cosmos_account_name=" + $azureConfiguration.cosmos.accountName
        $registryName = "container_registry_name=" + $azureConfiguration.containerRegistry.name

        #applies terraform to azure. Not confirmation required.
        terraform apply -auto-approve -var $resourceGroupVar -var $regionVar -var $cosmosAccountNameVar -var $registryName

        Write-Host "Completed...:)" -ForeGround Green
        
        Set-Location ../../
    }

    function Remove-AzureResources {

      Param(
          [parameter(mandatory=$true)] $azureConfiguration
        )

        Set-Location ./terraform/module
    
        Write-Host "Destroying infrastructure..." -ForeGround Yellow
        
        $resourceGroupVar = "resource_group_name=" + $azureConfiguration.resourceGroupName
        $regionVar = "default_region=" + $azureConfiguration.region
        $cosmosAccountNameVar = "cosmos_account_name=" + $azureConfiguration.cosmos.accountName
        $registryName = "container_registry_name=" + $azureConfiguration.containerRegistry.name

        #applies terraform to azure. Not confirmation required.
        terraform destroy -auto-approve -var $resourceGroupVar -var $regionVar -var $cosmosAccountNameVar -var $registryName

        Write-Host "Completed...:)" -ForeGround Green

        Set-Location ../../
    }
    
    Export-ModuleMember -Function Build-AzureResources, Remove-AzureResources
    
    } | Import-Module