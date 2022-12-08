public abstract class QueueableWrapper extends QueueableBase {
    private static Integer counter = 0;
    public String name;
    public QueueableWrapper(String name) {
        super(name);
    }
    protected abstract void work();

    protected virtual override void doLogic() {
        this.work();
    }
}

