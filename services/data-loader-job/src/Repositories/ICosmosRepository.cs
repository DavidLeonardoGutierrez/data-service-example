using System.Threading.Tasks;
using Data.Loader.Job.Models;
using Microsoft.Azure.Cosmos;

namespace Data.Loader.Job.Repositories
{
    public interface ICosmosRepository
    {
        void Insert(DataModel item);
    }
}
