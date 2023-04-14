using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agence.DataAccess.Repository
{
    interface IRepository<T, U>
    {
        public IEnumerable<U> List();
        public RequestStatus Insert(T item);
        public RequestStatus Update(T item);
        public U find(int? id); //<3 uwu <3
        public RequestStatus Delete(T item);
    }

}

