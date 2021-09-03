package io.lumen.edgevm.worker;

import com.netflix.conductor.client.worker.Worker;
import com.netflix.conductor.common.metadata.tasks.Task;
import com.netflix.conductor.common.metadata.tasks.TaskResult;
import io.lumen.edgevm.model.DataCenter;
import io.lumen.edgevm.model.Group;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.web.client.RestTemplate;

import static com.netflix.conductor.common.metadata.tasks.TaskResult.Status.COMPLETED;
import static com.netflix.conductor.common.metadata.tasks.TaskResult.Status.FAILED;

public class GroupWorker implements Worker {

    private final RestTemplate restTemplate;

    public GroupWorker(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }
    @Override
    public String getTaskDefName() {
        return "get_group_id";
    }

    @Override
    public TaskResult execute(Task task) {
        TaskResult result = new TaskResult(task);
        try {
            String accountAlias = (String) task.getInputData().get("accountAlias");
            String dataCenterName = (String) task.getInputData().get("dataCenter");

            String bearerToken = (String) task.getInputData().get("bearerToken");
            HttpHeaders headers = new HttpHeaders();
            headers.set(HttpHeaders.AUTHORIZATION, "Bearer " + bearerToken);

            // Get Data Center details to get hardware group link
            String dataCenterEndpoint = String.format("https://api.ctl.io/v2/datacenters/%s/%s?groupLinks=true", accountAlias, dataCenterName);
            DataCenter dataCenter = restTemplate.exchange(dataCenterEndpoint, HttpMethod.GET, new HttpEntity<>(headers), DataCenter.class).getBody();

            // Get Hardware Group details which gives me all sub-groups
            String hardwareGroupID = dataCenter.getHardwareGroupID();
            String groupEndpoint = String.format("https://api.ctl.io/v2/groups/%s/%s", accountAlias, hardwareGroupID);
            Group hardwareGroup = restTemplate.exchange(groupEndpoint, HttpMethod.GET, new HttpEntity<>(headers), Group.class).getBody();

            // Lookup group id based on name
            String groupName = (String) task.getInputData().get("groupName");
            Group requestedGroup = hardwareGroup.findGroupByName(groupName);

            result.setStatus(COMPLETED);
            result.getOutputData().put("groupId", requestedGroup.getId());
        } catch (Exception e) {
            result.setStatus(FAILED);
        }
        return result;
    }
}
