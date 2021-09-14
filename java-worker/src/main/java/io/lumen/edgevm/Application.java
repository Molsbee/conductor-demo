package io.lumen.edgevm;

import com.netflix.conductor.client.automator.TaskRunnerConfigurer;
import com.netflix.conductor.client.http.TaskClient;
import com.netflix.conductor.client.worker.Worker;
import io.lumen.edgevm.worker.*;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;

public class Application {

    private static final int THREAD_COUNT = 11;

    public static void main(String[] args) {
        TaskClient taskClient = new TaskClient();
        taskClient.setRootURI("http://127.0.0.1:8080/api/");

        RestTemplate restTemplate = new RestTemplate();
        Worker authenticationWorker = new AuthenticationWorker(restTemplate);
        Worker groupWorker = new GroupWorker(restTemplate);
        CreateServerWorker createServerWorker = new CreateServerWorker(restTemplate);

        DynamicCustomerSetupWorker dynamicCustomerSetupWorker = new DynamicCustomerSetupWorker();
        OpenstackDomainWorker openstackDomainWorker = new OpenstackDomainWorker();
        OpenstackProjectWorker openstackProjectWorker = new OpenstackProjectWorker();
        OpenstackUserWorker openstackUserWorker = new OpenstackUserWorker();
        OpenstackGroupWorker openstackGroupWorker = new OpenstackGroupWorker();
        OpenstackPermissionWorker openstackPermissionWorker = new OpenstackPermissionWorker();
        MorpheusCloudWorker morpheusCloudWorker = new MorpheusCloudWorker();
        MorpheusTenantWorker morpheusTenantWorker = new MorpheusTenantWorker();
        TaskRunnerConfigurer configurer = new TaskRunnerConfigurer.Builder(taskClient, Arrays.asList(authenticationWorker, groupWorker, createServerWorker,
                dynamicCustomerSetupWorker,
                openstackDomainWorker, openstackProjectWorker, openstackUserWorker, openstackGroupWorker, openstackPermissionWorker,
                morpheusCloudWorker, morpheusTenantWorker))
                .withThreadCount(THREAD_COUNT)
                .build();

        // Starts the polling and execution of tasks
        configurer.init();
    }
}
