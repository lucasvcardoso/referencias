using System;
namespace CircularArrayThing
{
    class CircularArrayAccess
    {
        static void Main(string[] args)
        {
            int[] array = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
            for (int i = 0; i < array.Length * 200; i++)
            {
                //Accessing position using the mod, will alway refer back to the start position of the array
                //Console.WriteLine(array[i % array.Length]);
                Console.WriteLine("{0} % {1} = {2}", i, array.Length, i % array.Length);
            }
        }
    }
}