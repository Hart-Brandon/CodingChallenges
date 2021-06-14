using System;
using System.Text.RegularExpressions;
using System.Collections.Generic;

/***********************
    Requirements - Given a list of emails, Return number of unique addresses

    Example email:  team.1+bob@somewhere.com
    Local address of email (team.1+bob)
    Periods (.) are removed
    Remove everything after a Plus (+)
    Final Local address will only have letters and numbers

    Example email:  team.1+bob@somewhere.com
    Domain address of email (somewhere.com)
    Can have lowercase letters and Periods (.)

    Example - Send to same email address
    team1@somwhere.com, team.1+bob@somewhere.com, team1+jill+bob@somewhere.com

    Example - Send to different email addresses
    team2@somewhere.com, team2@some.where.com
***********************/

namespace UniqueEmailAddresses
{
    public class Solution
    {
        static void Main(string[] args)
        {
            NumberOfUniqueEmailAddresses(args);
        }


        public static string[] TEST_EMAIL_LIST = new string[]{"team1@somewhere.com", "team.1+bob@somewhere.com", "team1+jill+bob@somewhere.com", 
                                                              "team2@somewhere.com", "team2@some.where.com", "team2@so1me.where.com",
                                                              "@somewhere.com", "team3", "team3+somewhere.com"};

        public static void NumberOfUniqueEmailAddresses(string[] emails)
        {
            // Doesn't allow duplicates to be added
            HashSet<string> cleanedEmails = new HashSet<string>();            
            HashSet<string> invalidEmails = new HashSet<string>();

            if (emails.Length == 0)
            {
                //emails = TEST_EMAIL_LIST;
                Console.WriteLine("No emails found.");
                return;
            }

            foreach(string email in emails)
            {
                try
                {
                    cleanedEmails.Add(CleanEmailString(email));
                }
                catch (Exception invalidEmail)
                {
                    invalidEmails.Add(invalidEmail.Message);
                }
            }

            DisplayEmailMessageInConsole(cleanedEmails, "\nUNIQUE EMAIL ADDRESSES: ");
            DisplayEmailMessageInConsole(invalidEmails, "\nINVALID EMAILS: ");
        }

        public const string KEEP_ALL_ALPHANUMERIC = @"[^a-zA-Z0-9]";
        public const string KEEP_ALL_ALPHA_AND_PERIOD = @"[^a-zA-Z.]";
        public static string CleanEmailString(string email)
        {
            // Splits email address into:
            // local address before + (first element)
            // local address after + (could be multiple but don't care about these)
            // domain after @ (last element)
            string[] emailToClean = email.Split(new Char[] { '+', '@' }, StringSplitOptions.RemoveEmptyEntries);
            
            if (emailToClean.Length < 2 || !email.Contains('@'))
                throw new Exception(email);
                        
            // Clean email address
            string localAddressToClean = emailToClean[0];
            string domainAddressToClean = emailToClean[emailToClean.Length - 1]; 

            string cleanedLocalAddress = Regex.Replace(localAddressToClean, KEEP_ALL_ALPHANUMERIC, "");
            string cleanedDomainAddress = Regex.Replace(domainAddressToClean, KEEP_ALL_ALPHA_AND_PERIOD, "");         

            string cleanedEmailAddress = String.Concat(cleanedLocalAddress, "@", cleanedDomainAddress);

            return cleanedEmailAddress.Trim();
        }

        public static void DisplayEmailMessageInConsole(HashSet<string> emailList, string messageSubject)
        {
            Console.WriteLine($"{messageSubject}{emailList.Count}");

            if (emailList.Count > 0)
            {
                foreach(string email in emailList)
                    Console.WriteLine(email);
            }
        }
    }
}
