using Amazon;
using Amazon.Runtime;
using Amazon.S3;
using Amazon.S3.Model;
using System;

namespace S3Sample
{
    class GenPresignedURLTest
    {
        private const string bucketName = "kbcprivate";
        private const string objectKey = "00_PUBLIC/Degreed/EL0866_1on1_Wrksht.pdf";//"00_PUBLIC/Degreed/EL0866_1on1_Wrksht.pdf";
        // Specify your bucket region (an example region is shown).
        private static readonly RegionEndpoint bucketRegion = Amazon.RegionEndpoint.GetBySystemName("kbcprivate");
        private static IAmazonS3 s3Client;
        private static string _awsSecretKey = "BAypaFYAvKz4h57FNkCa2JqejI+nPtxwL603y1ZF";//"BAypaFYAvKz4h57FNkCa2JqejI+nPtxwL603y1ZF";
        private static string _awsAccessKey = "AKIA2B4R2X6X6IDS2PUB";//"AKIA2B4R2X6X6IDS2PUB";

        public static void Main()
        {
            var creds = new BasicAWSCredentials(_awsAccessKey, _awsSecretKey);
            s3Client = new AmazonS3Client(creds, bucketRegion);
            string urlString = GeneratePreSignedURL();
            Console.WriteLine(urlString);
            Console.ReadLine();
        }
        static string GeneratePreSignedURL()
        {
            string urlString = "";
            try
            {
                GetPreSignedUrlRequest request1 = new GetPreSignedUrlRequest
                {
                    BucketName = bucketName,
                    Key = objectKey,
                    Expires = DateTime.Now.AddMinutes(5),
                    Verb = HttpVerb.GET
                };
                urlString = s3Client.GetPreSignedURL(request1);
            }
            catch (AmazonS3Exception e)
            {
                Console.WriteLine("Error encountered on server. Message:'{0}' when writing an object", e.Message);
            }
            catch (Exception e)
            {
                Console.WriteLine("Unknown encountered on server. Message:'{0}' when writing an object", e.Message);
            }
            return urlString;
        }
    }
}