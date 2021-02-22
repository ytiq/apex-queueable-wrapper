public abstract class QueueableWrapper implements Queueable, Database.AllowsCallouts {
    private static Integer counter = 0;
    public String name;
    public QueueableWrapper(String name) {
        this.name = name + '.' + ++counter + System.now().format();
    }
    abstract void work();

    public void execute(QueueableContext ctx) {
        System.debug('>>> start :' + this.name);
        this.work();
        currentChain.commitQueue();
    }

    public static void enqueue(QueueableWrapper queueable) {
        currentChain.add(queueable);
        if (!System.isQueueable()) {
            System.enqueueJob(queueable);
        }
    }

    private class QueueableChain implements Queueable {
        private List<QueueableWrapper> chain = new List<QueueableWrapper>();
        public void execute(QueueableContext ctx) {
            if (this.chain.isEmpty()) {
                return;
            }
            QueueableWrapper current = this.chain.remove(0);

            if (!this.chain.isEmpty()) {
                for (QueueableWrapper queueable : this.chain) {
                    enqueue(queueable);
                }
            }

            current.execute(ctx);
        }

        public void add(QueueableWrapper queueable) {
            if (queueable == null) {
                return;
            }
            this.chain.add(queueable);
        }

        public void commitQueue() {
            System.enqueueJob(this);
        }
    }
    private static final QueueableChain currentChain = new QueueableChain();
}

