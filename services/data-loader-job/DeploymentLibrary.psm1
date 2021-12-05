New-Module -Name DataLoaderJobModule -ScriptBlock {
<#
 .Synopsis
  Builds image of the Data Loader Job.

 .Description
  Builds image of the Data Loader Job. Optionally, the module pushes the image to a given Azure container registry.
#>
function Build-DataLoaderJobImage {

    Param(
      [parameter(mandatory=$true)] $dataLoaderConfiguration,
      [parameter(mandatory=$false)] $pushToContainerRegistry = $false
    )
    Set-Location ./services/data-loader-job/src

    Write-Host "Compiling And Building Image..." -ForeGround Yellow
    
    #Remove old image 
    docker rmi $(docker images -q $DataLoaderConfiguration.imagename | uniq) --force
    
    $imageFullName = [string]::Format("{0}:{1}", $dataLoaderConfiguration.imagename, $dataLoaderConfiguration.imageTag)
    
    #Create Image
    docker build -t $imageFullName -f ./Dockerfile . 

    Write-Host "Completed...:)" -ForeGround Green

    if ($pushToContainerRegistry) {
        Write-Host "Uploading the image to the Azure container registry..." -ForeGround Yellow

        $imageFullName = [string]::Format("{0}:{1}", $dataLoaderConfiguration.imagename, $dataLoaderConfiguration.imageTag)
        $imageContainerRegistryPath = [string]::Format("{0}.azurecr.io/{1}:{2}", $dataLoaderConfiguration.containerRegistryName, $dataLoaderConfiguration.imagename, $dataLoaderConfiguration.imageTag)
        
        docker tag $imageFullName $imageContainerRegistryPath
        
        az acr login -n $dataLoaderConfiguration.containerRegistryName
        
        docker push $imageContainerRegistryPath
        
        Write-Host "Completed...:)" -ForeGround Green
    }

    Set-Location ../../../
}

Export-ModuleMember -Function Build-DataLoaderJobImage

} | Import-Module