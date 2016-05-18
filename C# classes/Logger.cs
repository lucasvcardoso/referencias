using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DomainScannerFileMerger
{
    static class Logger
    {
        private static StreamWriter _writer;
        public static void Log(string logMessage, string logType)
        {
            using (_writer = new StreamWriter(@".\FileMerger.log", append: true))
            {
                _writer.WriteLine(string.Format("{0}[{1}] - {2}", DateTime.Now.ToString("dd/MM/yyyy HH:MM:ss"), logType, logMessage));
            }
        }
        
        public enum LogType { ERROR, INFO, WARNING };
    }
}
