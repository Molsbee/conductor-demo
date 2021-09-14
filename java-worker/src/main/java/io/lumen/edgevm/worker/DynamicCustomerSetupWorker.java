package io.lumen.edgevm.worker;

import com.netflix.conductor.client.worker.Worker;
import com.netflix.conductor.common.metadata.tasks.Task;
import com.netflix.conductor.common.metadata.tasks.TaskResult;
import io.lumen.edgevm.model.SubWorkflowDef;
import io.lumen.edgevm.model.SubWorkflowParam;
import io.lumen.edgevm.model.WorkflowDef;
import io.lumen.edgevm.model.WorkflowTask;

import java.util.*;

import static com.netflix.conductor.common.metadata.tasks.TaskResult.Status.COMPLETED;

public class DynamicCustomerSetupWorker implements Worker {

    private static final List<String> TASKS = Arrays.asList("openstack_create_domain",
            "openstack_create_project", "openstack_create_user", "openstack_create_group",
            "openstack_set_permissions", "morpheus_create_cloud", "morpheus_create_tenant_group");

    @Override
    public String getTaskDefName() {
        return "dynamic_customer_setup";
    }

    @Override
    public TaskResult execute(Task task) {
        List<String> sites = (List<String>) task.getInputData().get("sites");

        ArrayList<SubWorkflowDef> subWorkflows = new ArrayList<>();
        HashMap<String, Map<String, Object>> dynamicTasksInput = new HashMap<>();
        List<String> joinTaskReferenceNames = new ArrayList<>();
        sites.forEach(s -> {
            String subWorkflowTaskReferenceName = "sub_workflow_" + s;
            Map<String, Object> subWorkflowInputParameters = new HashMap<>();
            subWorkflowInputParameters.put("site", s);

            ArrayList<WorkflowTask> tasks = new ArrayList<>();
            SubWorkflowDef subWorkflowDef = SubWorkflowDef.builder()
                    .name(subWorkflowTaskReferenceName)
                    .taskReferenceName(subWorkflowTaskReferenceName)
                    .inputParameters(subWorkflowInputParameters)
                    .subWorkflowParam(SubWorkflowParam.builder()
                            .name("setup_customer_sub_workflow")
                            .version(1)
                            .workflowDefinition(WorkflowDef.builder()
                                    .name("setup_customer_workflow")
                                    .description("setup customer in openstack and morpheus")
                                    .tasks(tasks)
                                    .build())
                            .build())
                    .build();

            dynamicTasksInput.put("sub_workflow_" + s, subWorkflowInputParameters);
            TASKS.forEach(taskName -> {
                String taskReferenceName = taskName + "_" + s;
                HashMap<String, Object> inputParameters = new HashMap<>();
                inputParameters.put("site", "${workflow.input.site}");

                WorkflowTask workflowTask = WorkflowTask.builder()
                        .name(taskName)
                        .taskReferenceName(taskReferenceName)
                        .inputParameters(inputParameters)
                        .build();
                tasks.add(workflowTask);
//                dynamicTasksInput.put(workflowTask.getTaskReferenceName(), subWorkflowInputParameters);
            });

            subWorkflows.add(subWorkflowDef);
//            joinTaskReferenceNames.add(taskGroup.get(taskGroup.size() - 1).getTaskReferenceName());
        });

        TaskResult result = new TaskResult(task);
        result.setStatus(COMPLETED);
        result.getOutputData().put("dynamicTasksJSON", subWorkflows);
        result.getOutputData().put("dynamicTasksInputJSON", dynamicTasksInput);
        result.getOutputData().put("joinTaskReferenceNames", joinTaskReferenceNames);
        return result;
    }
}
