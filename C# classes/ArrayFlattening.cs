using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp4
{
    class Program
    {
        static void Main(string[] args)
        {
            /*
             * Input: [1,2,3,[1,[2,3]]]
             * Output: [1,2,3,1,2,3]
            */
            List<object> input = new List<object> {
                1,
                2,
                3,
                new object[]{
                    1,
                    new object[]{
                        2,
                        3
                    }
                }
            };

            List<object> output = FlattenArray(input).ToList();

            foreach (var item in output)
            {
                Console.WriteLine(item.ToString());
            }
        }

        private static IEnumerable<object> FlattenArray(IEnumerable<object> input)
        {
            return input.SelectMany(x => x is IEnumerable<object> ? FlattenArray((IEnumerable<object>)x) : Enumerable.Repeat(x, 1));
        }

        private static List<object> FlattenArray(object[] input)
        {
            List<object> output = new List<object>();

            foreach (var item in input)
            {
                List<object> aux = null;
                if (item.GetType().Equals(typeof(Object[])))
                {
                    aux = FlattenArray((object[])item);
                }
                else
                {
                    output.Add(item);
                }
                if (aux != null)
                {
                    output.AddRange(aux);
                }
            }

            return output;
        }
    }
}
