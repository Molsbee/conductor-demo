package io.lumen.edgevm.worker;

import com.netflix.conductor.client.worker.Worker;
import com.netflix.conductor.common.metadata.tasks.Task;
import com.netflix.conductor.common.metadata.tasks.TaskResult;
import com.netflix.conductor.common.metadata.tasks.TaskResult.Status;

public class DemoWorker implements Worker {

    @Override
    public String getTaskDefName() {
        return "demo-worker";
    }

    @Override
    public TaskResult execute(Task task) {
        TaskResult result = new TaskResult(task);
        result.setStatus(Status.COMPLETED);
        result.getOutputData().put("out", "value");
        return result;
    }
}
