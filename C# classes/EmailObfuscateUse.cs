
namespace EmailObfuscate 
{
    class EmailObfuscate
    {
        /// <summary>
        /// Need to install Simple.EmailObfuscator from NuGet
        /// </summary>
        public void EmailObfuscate()
        {
            Console.WriteLine(Email.Obfuscate("contoso@bichoso.com", numberOfAsterisks: 8, section: EmailOptions.ObfuscateEnd));

            Console.ReadLine();
        }
    }
}