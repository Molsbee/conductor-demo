package io.lumen.edgevm.worker;

import com.netflix.conductor.client.worker.Worker;
import com.netflix.conductor.common.metadata.tasks.Task;
import com.netflix.conductor.common.metadata.tasks.TaskResult;
import io.lumen.edgevm.model.clc.CreateServerRequest;
import io.lumen.edgevm.model.clc.QueueResponse;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import static com.netflix.conductor.common.metadata.tasks.TaskResult.Status.COMPLETED;
import static com.netflix.conductor.common.metadata.tasks.TaskResult.Status.FAILED;

public class CreateServerWorker implements Worker {

    private static final DateTimeFormatter TTL_FORMAT = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss'Z'");
    private final RestTemplate restTemplate;

    public CreateServerWorker(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    @Override
    public String getTaskDefName() {
        return "create_server";
    }

    @Override
    public TaskResult execute(Task task) {
        TaskResult result = new TaskResult(task);
        try {
            String accountAlias = (String) task.getInputData().get("accountAlias");
            String groupId = (String) task.getInputData().get("groupId");

            String bearerToken = (String) task.getInputData().get("bearerToken");
            HttpHeaders headers = new HttpHeaders();
            headers.set(HttpHeaders.AUTHORIZATION, "Bearer " + bearerToken);


            String endpoint = String.format("https://api.ctl.io/v2/servers/%s", accountAlias);
            CreateServerRequest request = CreateServerRequest.builder()
                    .name("NETCON")
                    .groupId(groupId)
                    .type("standard")
                    .sourceServerId("UBUNTU-16-64-TEMPLATE")
                    .cpu(2)
                    .memoryGB(4)
                    .password("ConductorPassword!")
                    .ttl(LocalDateTime.from(LocalDateTime.now()).plusDays(1).format(TTL_FORMAT))
                    .build();
            QueueResponse response = restTemplate.exchange(endpoint, HttpMethod.POST, new HttpEntity<>(request, headers), QueueResponse.class).getBody();

            result.setStatus(COMPLETED);
            result.getOutputData().put("serverUUID", response.getServerUUID());
        } catch (Exception e) {
            result.setStatus(FAILED);
        }

        return result;
    }
}
