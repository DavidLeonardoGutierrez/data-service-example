using Autofac;
using Data.Loader.Job.Services;

namespace Data.Loader.Job
{
    public class Program
    {
        static void Main(string[] args)
        {
            new ContainerBuilder()
            .RegisterDependencies()
            .Build()
            .Resolve<IDataLoaderJob>()
            .Run();
        }
    }
}
