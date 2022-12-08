public class TestAsyncInception extends AsyncApex {
    public TestAsyncInception() {
        super('Test async inception');
    }
    public override Object work() {

        Integer finalResult = (Integer) await(new Calculator());

        System.debug('aaaaaaaaaaa ' + finalResult);

        return 0;
    }

    private class Calculator extends AsyncApex {
        public Calculator() {
            super('calculator');
        }
        public override Object work() {
            Integer a = 4;

            a = (Integer) await (new Sum(a, 2));

            a = (Integer) await (new Sum(a, a));


            return a;

        }
    }

    private class Sum extends AsyncApex {
        Integer a;
        Integer b;

        public Sum(Integer a, Integer b) {
            super('sum');
            this.a = a;
            this.b = b;
        }

        public override Object work() {
            return a + b;
        }
    }
}
