using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LinqProblem
{
    class Program
    {
        static void Main(string[] args)
        {
            int[] numbers = { 3, 4, 5, 5, 3, 4, 5, 1 };

            var result = numbers
                .Where(n => n % 2 == 1)//Je selectionne les numéros que sont impaires
                .GroupBy(g => g)//Je leur groupe, en obtenant une lookup table
                /*
                Lookup table
                |Key|Values|
                |3  |3,3   |
                |5  |5,5,5 |
                |1  |1     |
                */
                .Select(lookupItem => lookupItem.Key * lookupItem.Count())//Je selectionne la multiplication de les clés (les numéros selectionnées) de le table pour la quantité de les articles dans le registre (les numéros)                
                .Sum(); //Je les additionne.

            //foreach (var item in result)
            //{
            //    Console.WriteLine("Grouping: ");
            //    //foreach (var i in item)
            //    {
            //        Console.WriteLine(item);
            //    }
            //}
            Console.WriteLine(result);
            Console.ReadLine();
        }
    }
}
