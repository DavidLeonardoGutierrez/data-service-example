New-Module -Name KubernetesModule -ScriptBlock {
    <#
     .Synopsis
      Builds the Azure resources.
    
     .Description
      The mocule uses terraform to create the Azure resources needed by the services.
    #>
    function Start-Cluster {
    
        Param(
          [parameter(mandatory=$true)] $kubernetesConfiguration
        )

        Set-Location ./terraform/module
    
        Write-Host "Starting Kubernetes cluster ..." -ForeGround Yellow

        #starts minikube
        minikube start --nodes $kubernetesConfiguration.nodes --cpus $kubernetesConfiguration.cpus --memory $kubernetesConfiguration.memory  --kubernetes-version $kubernetesConfiguration.kubernetesVersion

        Write-Host "Completed...:)" -ForeGround Green
        
        Set-Location ../../
    }

    function Remove-Cluster {

        Set-Location ./terraform/module
    
        Write-Host "Removing cluster..." -ForeGround Yellow
        
        minikube delete

        Write-Host "Completed...:)" -ForeGround Green

        Set-Location ../../
    }
    
    Export-ModuleMember -Function Start-Cluster, Remove-Cluster
    
    } | Import-Module