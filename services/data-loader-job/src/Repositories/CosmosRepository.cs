using System;
using System.Threading.Tasks;
using Data.Loader.Job.Models;
using Microsoft.Azure.Cosmos;

namespace Data.Loader.Job.Repositories
{
    public class CosmosRepository : ICosmosRepository
    {
        public CosmosRepository(CosmosClient cosmosClient, DataAccessConfigurationModel configurationModel)
        {
            this._cosmosClient = cosmosClient ?? throw new ArgumentNullException(nameof(_cosmosClient));

            this._configurationModel = configurationModel ?? throw new ArgumentNullException(nameof(configurationModel));
        }

        private CosmosClient _cosmosClient;

        private DataAccessConfigurationModel _configurationModel;

        public async void Insert(DataModel item)
        {
            await this.GetContainer().CreateItemAsync(item);
        }
        private async Task<Database> CreateDataBase()
        {
            return await this._cosmosClient.CreateDatabaseIfNotExistsAsync(this._configurationModel.DataBaseName);
        }

        private Container GetContainer()
        {
            return this._cosmosClient.GetContainer(this._configurationModel.DataBaseName, this._configurationModel.ContainerName) 
            ?? throw new Exception("The container does not exist. Please make sure it was created.");
        }
    }
}