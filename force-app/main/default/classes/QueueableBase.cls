public abstract class QueueableBase implements Queueable, Database.AllowsCallouts {
    public String name;
    public QueueableBase(String name) {
        this.name = '"' + name + '":' + currentChain.getNextCount() + ':' + System.now().format();
    }

    protected virtual void doLogic() {
    }

    public virtual void execute(QueueableContext ctx) {
        System.debug('>>> start :' + this.name);

        this.doLogic();

        currentChain.commitQueue();
    }

    protected Boolean isChainEmpty() {
        return currentChain.chain.isEmpty();
    }
    public static void enqueueJob(QueueableBase queueable) {
        currentChain.add(queueable);
        if (!System.isQueueable()) {
            System.enqueueJob(queueable);
        }
    }

    private class QueueableChain implements Queueable, Database.AllowsCallouts {
        private Integer counter = 0;
        private List<QueueableBase> chain = new List<QueueableBase>();
        public void execute(QueueableContext ctx) {
            if (this.chain.isEmpty()) {
                return;
            }
            QueueableBase current = this.chain.remove(0);

            if (!this.chain.isEmpty()) {
                for (QueueableBase queueable : this.chain) {
                    enqueueJob(queueable);
                }
            }

            current.execute(ctx);
        }

        public Integer getNextCount() {
            return ++this.counter;
        }

        public void add(QueueableBase queueable) {
            if (queueable == null) {
                return;
            }
            this.chain.add(queueable);
        }

        public void commitQueue() {
            if (this.chain.isEmpty()) {
                return;
            }
            System.enqueueJob(this);
        }
    }
    private static final QueueableChain currentChain = new QueueableChain();
}
