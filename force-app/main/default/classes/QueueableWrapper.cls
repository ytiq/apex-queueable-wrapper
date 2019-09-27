public abstract class QueueableWrapper implements Queueable {
    private static Integer counter = 0;
    public String name;
    public QueueableWrapper(String name) {
        this.name = name + '.' + ++counter + System.now().format();
    }
    abstract void work();

    public void execute(QueueableContext ctx) {
        this.work();
        currentChain.commitQueue();
    }

    public static void enqueue(Queueable queueable) {
        currentChain.add(queueable);
        if (!System.isQueueable()) {
            System.enqueueJob(queueable);
        }
    }

    public class QueueableChain implements Queueable {
        private List<Queueable> chain = new List<Queueable>();
        private Queueable current;

        public void execute(QueueableContext ctx) {
            if (!this.chain.isEmpty()) {
                for (Queueable queueable : this.chain) {
                    enqueue(queueable);
                }
            }

            if (this.current == null) {
                return;
            }

            this.current.execute(ctx);
        }

        public void add(Queueable queueable) {
            if (this.current == null) {
                this.current = queueable;
            } else {
                this.chain.add(queueable);
            }

        }

        public void commitQueue() {
            System.enqueueJob(this);
        }
    }
    public static QueueableChain currentChain = new QueueableChain();
}

