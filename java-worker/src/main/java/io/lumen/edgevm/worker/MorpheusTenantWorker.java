package io.lumen.edgevm.worker;

import com.netflix.conductor.client.worker.Worker;
import com.netflix.conductor.common.metadata.tasks.Task;
import com.netflix.conductor.common.metadata.tasks.TaskResult;

import static com.netflix.conductor.common.metadata.tasks.TaskResult.Status.COMPLETED;

public class MorpheusTenantWorker implements Worker {
    @Override
    public String getTaskDefName() {
        return "morpheus_create_tenant_group";
    }

    @Override
    public TaskResult execute(Task task) {
        TaskResult result = new TaskResult(task);
        result.setStatus(COMPLETED);
        return result;
    }
}