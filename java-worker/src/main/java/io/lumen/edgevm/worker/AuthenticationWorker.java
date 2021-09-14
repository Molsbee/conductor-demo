package io.lumen.edgevm.worker;

import com.netflix.conductor.client.worker.Worker;
import com.netflix.conductor.common.metadata.tasks.Task;
import com.netflix.conductor.common.metadata.tasks.TaskResult;
import io.lumen.edgevm.model.clc.ClcAuthorization;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

import static com.netflix.conductor.common.metadata.tasks.TaskResult.Status.COMPLETED;
import static com.netflix.conductor.common.metadata.tasks.TaskResult.Status.FAILED;

public class AuthenticationWorker  implements Worker {

    private final RestTemplate restTemplate;

    public AuthenticationWorker(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    @Override
    public String getTaskDefName() {
        return "get_bearer_token";
    }

    @Override
    public TaskResult execute(Task task) {
        TaskResult result = new TaskResult(task);
        try {
            String username = (String) task.getInputData().get("username");
            String password = (String) task.getInputData().get("password");

            Map<String, String> request = new HashMap<>();
            request.put("username", username);
            request.put("password", password);

            ClcAuthorization authorization = restTemplate.postForObject("https://api.ctl.io/v2/authentication/login", request, ClcAuthorization.class);

            result.setStatus(COMPLETED);
            result.getOutputData().put("bearerToken", authorization.getBearerToken());
        } catch (Exception e) {
            result.setStatus(FAILED);
        }

        return result;
    }
}
