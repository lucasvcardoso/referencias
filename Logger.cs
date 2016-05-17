static class Logger
    {
        private static StreamWriter _writer;
        public static void LogError(string errorMessage)
        {
            using (_writer = new StreamWriter(@".\FileMerger.log", append: true))
            {
                _writer.WriteLine(string.Format("{0}[ERROR] - {1}", DateTime.Now.ToString("dd/MM/yyyy HH:MM:ss"), errorMessage));
            }
        }

        public static void LogWarning(string warningMessage)
        {
            using (_writer = new StreamWriter(@".\FileMerger.log", append: true))
            {
                _writer.WriteLine(string.Format("{0}[WARNING] - {1}", DateTime.Now.ToString("dd/MM/yyyy HH:MM:ss"), warningMessage));
            }
        }

        public static void LogInfo(string infoMessage)
        {
            using (_writer = new StreamWriter(@".\FileMerger.log", append: true))            {
                _writer.WriteLine(string.Format("{0}[INFO] - {1}", DateTime.Now.ToString("dd/MM/yyyy HH:MM:ss"), infoMessage));
            }
        }
    }