public class Flow
{
    public static String formatF1F2F3(float f1, float f2, float f3)
    {
        return
          "f1 = " + f1 + ", f2 = " + f2 + ", f3 = " + f3;
    }

    //      The new record type is needed to
    //      so that the two results
    //      of adjustDistance can be returned together.
    //
    //      adjustDistance is a method inside this
    //      class so that parameter passing is simpler
    private static class TwoFlows
    {
        public float flow1;
        public float flow2;

        public TwoFlows(float flow1, float flow2)
        {
            this.flow1 = flow1;
            this.flow2 = flow2;
        }

        //      This method adjustDistance behaves like
        //      the function adjustDistance in flow.cpp.
        public void adjustDistance()
        {
            if ( Math.abs(flow1 - flow2) < 10 )
            {
                if(flow1 > flow2)
                {
                    flow2 = flow2 / 3;
                    flow1 = flow1 + flow2;
                    flow1 = flow1 + flow2;
                }
                else
                {
                    flow1 = flow1 / 3;
                    flow2 = flow2 + flow1;
                    flow2 = flow2 + flow1;
                }
            }
        }
    }

    public static void main(String[] args)
    {
        float f1, f2, f3;
        f1 = 3; f2 = 3; f3 = 4;
        
        System.out.println(formatF1F2F3(f1,f2,f3));

        TwoFlows flow1 = new TwoFlows(f2, f3);
        flow1.adjustDistance();
        f2 = flow1.flow1;
        f3 = flow1.flow2;
        System.out.println(formatF1F2F3(f1,f2,f3));

        TwoFlows flow2 = new TwoFlows(f1, f2);
        flow2.adjustDistance();
        f1 = flow2.flow1;
        f2 = flow2.flow2;
        System.out.println(formatF1F2F3(f1,f2,f3));

        TwoFlows flow3 = new TwoFlows(f3, f3);
        flow3.adjustDistance();
        // As value is copies, not passed by reference, a different outcome will occur here compared to C++ version
        // I could also assign f3 = flow3.flow1 before the next statement, however, as in this case it would be immediatly overwritten this has been ommited
        f3 = flow3.flow2;
        System.out.println(formatF1F2F3(f1,f2,f3));
    }
}