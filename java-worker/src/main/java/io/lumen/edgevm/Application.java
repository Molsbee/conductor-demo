package io.lumen.edgevm;

import com.netflix.conductor.client.automator.TaskRunnerConfigurer;
import com.netflix.conductor.client.http.TaskClient;
import com.netflix.conductor.client.worker.Worker;
import io.lumen.edgevm.worker.AuthenticationWorker;
import io.lumen.edgevm.worker.CreateServerWorker;
import io.lumen.edgevm.worker.GroupWorker;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;

public class Application {

    private static final int THREAD_COUNT = 3;

    public static void main(String[] args) {
        TaskClient taskClient = new TaskClient();
        taskClient.setRootURI("http://127.0.0.1:8080/api/");

        RestTemplate restTemplate = new RestTemplate();
        Worker authenticationWorker = new AuthenticationWorker(restTemplate);
        Worker groupWorker = new GroupWorker(restTemplate);
        CreateServerWorker createServerWorker = new CreateServerWorker(restTemplate);
        TaskRunnerConfigurer configurer = new TaskRunnerConfigurer.Builder(taskClient, Arrays.asList(authenticationWorker, groupWorker, createServerWorker))
                .withThreadCount(THREAD_COUNT)
                .build();

        // Starts the polling and execution of tasks
        configurer.init();
    }
}
