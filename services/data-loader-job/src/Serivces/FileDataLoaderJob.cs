using System;
using Data.Loader.Job.Models;
using Data.Loader.Job.Repositories;
using Microsoft.Extensions.Logging;

namespace Data.Loader.Job.Services
{
    public class FileDataLoaderJob : IDataLoaderJob
    {

        /// <summary>
        /// Inits the Service
        /// </summary>
        /// <param name="repository">The Cosmos Db Repository.</param>
        /// <param name="logger">The logger.</param>
        public FileDataLoaderJob(ICosmosRepository repository, ILogger logger)
        {
            this._repository = repository?? throw new ArgumentNullException(nameof(repository));
            this._logger = logger?? throw new ArgumentNullException(nameof(logger));
        }

        /// <summary>
        /// The repository.
        /// </summary>
        private ICosmosRepository _repository;

        /// <summary>
        /// The logger.
        /// </summary>
        private ILogger _logger;

        public void Run()
        {
            this._logger.LogInformation("Starting Demo.");

            this._logger.LogWarning("Adding new pet to the collection...");

            var cat = new DataModel
            {
                Name = "Mayonesa"
            };

            this._repository.Insert(cat);

            this._logger.LogWarning("The cat was added successfully.");

        }
    }
}