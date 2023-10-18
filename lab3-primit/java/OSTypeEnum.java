import java.util.Scanner;
import java.util.InputMismatchException;
import java.util.EnumSet;

public class OSTypeEnum
{
    enum OS { ANDROID, IOS, MACOSX, WINDOWS8, WP8, VXWORKS }
    
    enum OSType { DESKTOP, EMBEDDED, MOBILE }
    
    private static <E extends Enum<E>> E getEnumElement(String elementTypeName, Class<E> elementType)
    {
        boolean haveResult = false;
        E result = null;
        Scanner stdin = new Scanner(System.in);
        
        while ( ! haveResult )
        {
            System.out.print("Input " + elementTypeName + ": ");
            try
            {
                result = Enum.valueOf(elementType, stdin.next().toUpperCase());
                haveResult = true;
            }
            catch (IllegalArgumentException e)
            {
                System.out.println("Not a valid " + elementTypeName + ".");
                stdin.nextLine(); // skip the invalid input
            }
        }
        
        return result;
    }
  
    private static OSType os2OSType(OS os)
    {
        OSType type = null;
        
        switch (os)
        {
        case ANDROID:
        case IOS:
        case WP8:
            type = OSType.MOBILE;
            break;
        case WINDOWS8:
        case MACOSX:
            type = OSType.DESKTOP;
            break;
        case VXWORKS:
            type = OSType.EMBEDDED;
            break;
        }
        
        return type;
    }

    private static OS ost2OS(OSType ost) 
    {
        OS os = null;
        switch (ost) 
        {
            case MOBILE:
                os = OS.ANDROID;
                break;
            case DESKTOP:
                os = OS.WINDOWS8;
                break;
            case EMBEDDED:
                os = OS.VXWORKS;
                break;
        }

        return os;
    }

    private static void showOsToType() {
        System.out.print("Known OSs = ");
        for (OS t : EnumSet.allOf(OS.class)) 
        {
            System.out.print(t + " ");
        }
        System.out.println();
        
        OS os = getEnumElement("operating system", OS.class);
        System.out.println(os + " is of type: " + os2OSType(os));
    }

    private static void showTypeToOs() 
    {
        System.out.print("Known Types = ");
        for (OSType t : EnumSet.allOf(OSType.class)) 
        {
            System.out.print(t + " ");
        }
        System.out.println();
        
        OSType ost = getEnumElement("operating system type", OSType.class);
        System.out.println(ost2OS(ost) + " is an example of a " + ost + " operating system");
    }

    public static void main(String[] args)
    {
        showTypeToOs();
    }
}