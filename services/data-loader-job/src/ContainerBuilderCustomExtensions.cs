using System;
using Autofac;
using Data.Loader.Job.Services;
using Data.Loader.Job.Repositories;
using Data.Loader.Job.Models;
using Microsoft.Azure.Cosmos;
using Serilog;
using Serilog.Extensions.Logging;
using Serilog.Sinks.SystemConsole.Themes;

namespace Autofac
{
    public static class ContainerBuilderCustomExtensions
    {
        public static ContainerBuilder RegisterDependencies(this ContainerBuilder containerBuilder)
        {
            RegisterDataAccessConfigurationModel(containerBuilder);
            RegisterServices(containerBuilder);
            RegisterRepositories(containerBuilder);
            RegisterLogging(containerBuilder);
            RegisterCosmosClient(containerBuilder);

            return containerBuilder;
        }

        private static void RegisterServices(ContainerBuilder containerBuilder)
        {
            containerBuilder.RegisterType<FileDataLoaderJob>().As<IDataLoaderJob>();
        }

        private static void RegisterRepositories(ContainerBuilder containerBuilder)
        {
            containerBuilder.RegisterType<CosmosRepository>().As<ICosmosRepository>();
        }

        private static void RegisterLogging(ContainerBuilder containerBuilder)
        {
            Log.Logger = new LoggerConfiguration()
                            .WriteTo.Console(theme: AnsiConsoleTheme.Code)
                            .CreateLogger();

            containerBuilder.RegisterInstance<Microsoft.Extensions.Logging.ILogger>(
                new SerilogLoggerProvider().CreateLogger("Happy logging"));
        }

        private static void RegisterCosmosClient(ContainerBuilder containerBuilder)
        {
            containerBuilder.Register(_ => 
            {
                var connectionString =  Environment.GetEnvironmentVariable("COSMOS_CONNECTION");
                return new CosmosClient(connectionString);
            });
        }

        private static void RegisterDataAccessConfigurationModel(ContainerBuilder containerBuilder)
        {
            containerBuilder.RegisterInstance<DataAccessConfigurationModel>(
                new DataAccessConfigurationModel
                {
                    ContainerName = Environment.GetEnvironmentVariable("COSMOS_CONTAINER"),
                    DataBaseName = Environment.GetEnvironmentVariable("COSMOS_DATABASE"),
                    ContainerPath = Environment.GetEnvironmentVariable("COSMOS_CONTAINER_PATH")
                });
        }
    }
}
