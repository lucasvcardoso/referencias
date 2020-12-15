using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QueueTest
{
    class Program
    {
        static void Main(string[] args)
        {
            Queue<int> fila = new Queue<int>();
            int[] items = { 0, 30, 45, 77, 98, 190, 981 };

            var reverseItems = items.Reverse();
            foreach (var item in reverseItems)
            {
                fila.Enqueue(item);
            }
            

            //Console.WriteLine(fila.Dequeue());
            int queueLength = fila.output.Count;

            for (int s = 0; s < queueLength; s++)
            {
                Console.WriteLine(fila.Dequeue());
            }

            Console.ReadLine();
        }
    }
}
