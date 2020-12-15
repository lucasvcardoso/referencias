using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QueueTest
{
    public class Queue<T>
    {
        private Stack<T> input = new Stack<T>();
        public Stack<T> output = new Stack<T>();

        public void Enqueue(T item)
        {
            input.Push(item);
        }

        public T Dequeue ()
        {
            //Ce dessin a un probléme inhérent à le fait de que on a que faire une premiére 
            //opération de Dequeue() pour avoir une taille de la queue,
            //ce probléme a que être corrigées avant de se utilizer ce dessin
            if (output.Count == 0)
            {
                while(input.Count > 0)
                {
                    output.Push(input.Pop());
                }
            }
            return output.Pop();
        }
    }
}
