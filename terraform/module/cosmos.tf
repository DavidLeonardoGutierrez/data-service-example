#-----------------------------------------------------CosmosDb
resource "azurerm_cosmosdb_account" "db_account" {
  name                = var.cosmos_account_name
  location            = var.default_region
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  tags = {
    "layer" = "database"
  }

  enable_automatic_failover = true

  capabilities {
    name = "EnableAggregationPipeline"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    location          = var.default_region
    failover_priority = 0
  }
}
