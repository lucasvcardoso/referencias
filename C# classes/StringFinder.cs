public class StringFinder
{
    static List<string> _dbItems = new List<string> { items };
    static void Main(string[] args)
    {
        try
        {
            //Console.WriteLine();
            //Console.WriteLine();
            //foreach (string d in Directory.GetFiles(@directory, pattern, SearchOption.AllDirectories))
            //{
            //    //Console.WriteLine();
            //    SearchStrings(d);
            //}
            //Console.WriteLine();
            Console.WriteLine();
            Console.WriteLine();
            foreach (string d in Directory.GetFiles(@"file full path here", "pattern do search here" , SearchOption.AllDirectories))
            {
                //Console.WriteLine();
                SearchStrings(d);
            }
            Console.WriteLine();
            Console.WriteLine();
            Console.ReadLine();
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
        }

    }

    private static void SearchStrings(string d)
    {
        List<string> list = new List<string>();
        using (StreamReader reader = new StreamReader(d))
        {
            int lineNumber = 1;
            while (reader.Peek() >= 0)
            {
                var line = reader.ReadLine();
                foreach (string dbItem in _dbItems)
                {
                    if (line.ToUpper().IndexOf(dbItem.ToUpper()) > -1)
                    {
                        Console.WriteLine();
                        Console.WriteLine(d);
                        Console.WriteLine(line);
                        Console.WriteLine();
                    }
                }
                lineNumber++;
            }
        }
    }
}